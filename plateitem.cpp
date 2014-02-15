#include <QHash>

#include "plateitem.h"

PlateItem::PlateItem(const QString &name, const QString &wojewodztwo, QObject *parent) :
  QObject(parent), m_name(name), m_wojewodztwo(wojewodztwo)
{
}

void PlateItem::setPowiat(QString powiat)
{
    m_powiat = powiat;
    emit dataChanged();
}

void PlateItem::setMiasto(QString miasto)
{
    m_miasto = miasto;
    emit dataChanged();
}

QHash<int, QByteArray> PlateItem::roleNames() const
{
  QHash<int, QByteArray> names;
  names[NameRole] = "name";
  names[CategoryRole] = "category";
  names[WojewodztwoRole] = "wojewodztwo";
  names[PowiatRole] = "powiat";
  names[MiastoRole] = "miasto";
  return names;
}

QVariant PlateItem::data(int role) const
{
  switch(role) {
  case NameRole:
    return name();
  case CategoryRole:
    return category();
  case WojewodztwoRole:
    return wojewodztwo();
  case PowiatRole:
    return powiat();
  case MiastoRole:
    return miasto();
  default:
    return QVariant();
  }
}
