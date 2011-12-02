#ifndef TABLES_H
#define TABLES_H

#include <QObject>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlDatabase>
#include <QDir>

#include "listmodel.h"
#include "plateitem.h"

class Tables : public QObject {
    Q_OBJECT

public:
    explicit Tables(QObject *parent = 0);

public slots:
    void insertValuesIntoMain(int id, QString tableCode);
    void insertValuesIntoDetails(int id, QString wojewodztwo, QString powiat, QString miasto);
    void createMainTable();
    void createDetailsTable();
    void openDatabase();
    void closeDatabase();
    int getIdsNumber();
    QString getTableCodeFromId(int id);
    void setListModel(ListModel *model);
    void loadDataToModel();
    QString getWojewodztwoFromId(int id);
    QString getPowiatFromId(int id);
    QString getMiastoFromId(int id);
    void tabliceTymczasowe();

private:
    QSqlDatabase *db;
    ListModel *model;
};

#endif // TABLES_H
