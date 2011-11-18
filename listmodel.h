#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QVariant>

#include "plateitem.h"

class ListItem: public QObject {
  Q_OBJECT

public:
  ListItem(QObject* parent = 0) : QObject(parent) {}
  virtual ~ListItem() {}
  virtual QString id() const = 0;
  virtual QVariant data(int role) const = 0;
  virtual QHash<int, QByteArray> roleNames() const = 0;

signals:
  void dataChanged();
};

class ListModel : public QAbstractListModel
{
  Q_OBJECT

public:
    explicit ListModel(PlateItem* prototype, QObject* parent = 0);
    ~ListModel();

    ListModel* searchModel;

public slots:
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    void appendRow(PlateItem* item);
    void appendRows(const QList<PlateItem*> &items);
    void insertRow(int row, PlateItem* item);
    bool removeRow(int row, const QModelIndex &parent = QModelIndex());
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex());
    PlateItem* takeRow(int row);
    PlateItem* find(const QString &id) const;
    QModelIndex indexFromItem( const PlateItem* item) const;
    void clear();
    void handleItemChange();
    void searchFor(const QString &value);
    int checkIfNumbersNow(QString data);

private:
    PlateItem* m_prototype;
    QObject *parent;
    QList<PlateItem*> m_list;

};

#endif // LISTMODEL_H
