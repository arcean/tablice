#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QVariant>

#include "plateitem.h"
#include "settings.h"

class ListModel : public QAbstractListModel
{
    Q_OBJECT
    // Needed to make SectionScroller happy.
    Q_PROPERTY(int count READ rowCount)

public:
    explicit ListModel(PlateItem* prototype, QObject* parent = 0);
    ~ListModel();
    void setSettings(Settings *settings);

    // Needed to make SectionScroller happy.
    Q_INVOKABLE PlateItem* get(int index) { return new PlateItem(m_list.at(index)); }
    Q_INVOKABLE QString getCategoryStr(int index) { return m_list.at(index)->category(); }
    Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const;

    ListModel* searchModel;
    QList<PlateItem*> m_list;

public slots:
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
    void searchFor(const QString &value, bool mode);
    int checkIfNumbersNow(QString data);

signals:
    void emptyList(bool isEmpty);

private:
    PlateItem* m_prototype;
    QObject *parent;
    Settings *settings;

};

#endif // LISTMODEL_H
