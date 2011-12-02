#include "listmodel.h"

#include <QDebug>

ListModel::ListModel(PlateItem* prototype, QObject *parent) :
    QAbstractListModel(parent), m_prototype(prototype)
{
    setRoleNames(m_prototype->roleNames());
}

int ListModel::rowCount(const QModelIndex &parent) const
{
  Q_UNUSED(parent);
  return m_list.size();
}

QVariant ListModel::data(const QModelIndex &index, int role) const
{
  if(index.row() < 0 || index.row() >= m_list.size())
    return QVariant();
  return m_list.at(index.row())->data(role);
}

ListModel::~ListModel() {
  delete m_prototype;
  clear();
}

void ListModel::appendRow(PlateItem *item)
{
  appendRows(QList<PlateItem*>() << item);
}

void ListModel::appendRows(const QList<PlateItem *> &items)
{
  beginInsertRows(QModelIndex(), rowCount(), rowCount()+items.size()-1);
  foreach(PlateItem *item, items) {
    connect(item, SIGNAL(dataChanged()), SLOT(handleItemChange()));
    m_list.append(item);
  }
  endInsertRows();
}

void ListModel::insertRow(int row, PlateItem *item)
{
  beginInsertRows(QModelIndex(), row, row);
  connect(item, SIGNAL(dataChanged()), SLOT(handleItemChange()));
  m_list.insert(row, item);
  endInsertRows();
}

void ListModel::handleItemChange()
{
  PlateItem* item = static_cast<PlateItem*>(sender());
  QModelIndex index = indexFromItem(item);
  if(index.isValid())
    emit dataChanged(index, index);
}

PlateItem * ListModel::find(const QString &id) const
{
  foreach(PlateItem* item, m_list) {
    if(item->id() == id) return item;
  }
  return 0;
}

int ListModel::checkIfNumbersNow(QString data)
{
    if(data.length() > 2)
        if(data.at(2).isDigit())
            return 3;
    if(data.length() > 3)
        if(data.at(3).isDigit())
            return 4;

    return -1;
}

void ListModel::searchFor(const QString &value, bool mode)
{

    int number = checkIfNumbersNow(value);
    int chopAt = -1;
    QString newValue = value;

    if (number == 3)
        chopAt = newValue.length() - 2;
    else if (number == 4)
        chopAt = newValue.length() - 3;

    if(number != -1)
        newValue.chop(chopAt);

    QList<PlateItem*> cacheList;
    ListModel* cache = new ListModel(new PlateItem, this);

    if(mode) {
        searchModel->clear();
        foreach(PlateItem* item, m_list) {
            cacheList.append(item);
        }
    }
    else {
        foreach(PlateItem* item, searchModel->m_list) {
            cacheList.append(item);
        }
    }

    PlateItem *newItem;
    bool add = false;

    if(number == -1) {
        foreach(PlateItem* item, cacheList) {
            add = false;
            newItem = new PlateItem(item->name(), item->wojewodztwo());

            if(settings->getEnableSearchingByDistrict()) {
                if(item->powiat().startsWith(newValue, Qt::CaseInsensitive))
                    add = true;
            }
            if(settings->getEnableSearchingByCity()) {
                if(item->miasto().startsWith(newValue, Qt::CaseInsensitive))
                    add = true;
            }
            if(settings->getEnableSearchingByDistrictB()) {
                if(item->wojewodztwo().startsWith(newValue, Qt::CaseInsensitive))
                    add = true;
            }

            if(item->name().startsWith(newValue, Qt::CaseInsensitive) || add){
                newItem->setMiasto(item->miasto());
                newItem->setPowiat(item->powiat());
                cache->appendRow(newItem);
            }
        }
    }
    else {
        foreach(PlateItem* item, cacheList) {
            newItem = new PlateItem(item->name(), item->wojewodztwo());
            if(QString::compare(item->name(), newValue, Qt::CaseInsensitive) == 0){
                newItem->setMiasto(item->miasto());
                newItem->setPowiat(item->powiat());
                cache->appendRow(newItem);
            }
        }
    }
    searchModel->clear();
    foreach(PlateItem* item, cache->m_list) {
        searchModel->appendRow(item);
    }

}

QModelIndex ListModel::indexFromItem(const PlateItem *item) const
{
  Q_ASSERT(item);
  for(int row=0; row<m_list.size(); ++row) {
    if(m_list.at(row) == item) return index(row);
  }
  return QModelIndex();
}

void ListModel::clear()
{
  qDeleteAll(m_list);
  m_list.clear();
}

bool ListModel::removeRow(int row, const QModelIndex &parent)
{
  Q_UNUSED(parent);
  if(row < 0 || row >= m_list.size()) return false;
  beginRemoveRows(QModelIndex(), row, row);
  delete m_list.takeAt(row);
  endRemoveRows();
  return true;
}

bool ListModel::removeRows(int row, int count, const QModelIndex &parent)
{
  Q_UNUSED(parent);
  if(row < 0 || (row+count) >= m_list.size()) return false;
  beginRemoveRows(QModelIndex(), row, row+count-1);
  for(int i=0; i<count; ++i) {
    delete m_list.takeAt(row);
  }
  endRemoveRows();
  return true;
}

PlateItem * ListModel::takeRow(int row)
{
  beginRemoveRows(QModelIndex(), row, row);
  PlateItem* item = m_list.takeAt(row);
  endRemoveRows();
  return item;
}

void ListModel::setSettings(Settings *settings)
{
    this->settings = settings;
}
