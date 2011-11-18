#ifndef PLATEITEM_H
#define PLATEITEM_H

#include <QObject>
#include <QHash>
#include <QVariant>

//#include "listmodel.h"

class PlateItem : public QObject
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole+1,
        WojewodztwoRole,
        PowiatRole,
        MiastoRole
    };

public:
    PlateItem(QObject *parent = 0): QObject(parent) {}
    explicit PlateItem(const QString &name, const QString &wojewodztwo, QObject *parent = 0);
    QVariant data(int role) const;
    QHash<int, QByteArray> roleNames() const;
    inline QString id() const { return m_name; }
    inline QString name() const { return m_name; }
    inline QString wojewodztwo() const { return m_wojewodztwo; }
    inline QString powiat() const { return m_powiat; }
    inline QString miasto() const { return m_miasto; }
    void setPowiat(QString powiat);
    void setMiasto(QString miasto);

signals:
  void dataChanged();

private:
    QString m_name;
    QString m_wojewodztwo;
    QString m_powiat;
    QString m_miasto;
};

#endif // PLATEITEM_H
