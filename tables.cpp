#include <QVariant>

#include "tables.h"

Tables::Tables(QObject *parent) :
    QObject(parent) {
}

void Tables::openDatabase()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    QString path(QDir::separator());
    path.append("opt");
    path.append(QDir::separator()).append("tablice");
    path.append(QDir::separator()).append("data");
    path.append(QDir::separator()).append("tablice.db.sqlite");
    path = QDir::toNativeSeparators(path);
    db.setDatabaseName(path);
    db.open();
}

void Tables::closeDatabase()
{
    if(db->isOpen())
        db->close();
}

void Tables::setListModel(ListModel *model)
{
    this->model = model;
}

void Tables::createMainTable()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS main (id INT PRIMARY KEY, "
                    "tableCode VARCHAR(20))");
}

void Tables::createDetailsTable()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS details (id INT PRIMARY KEY, "
               "wojewodztwo VARCHAR(20), powiat VARCHAR(30), miasto VARCHAR(20))");
}

void Tables::insertValuesIntoMain(int id, QString tableCode)
{
    QSqlQuery query;

    if (id == -1) {
        /* It's time for auto increment function */
        query.exec(QString("INSERT INTO main VALUES(NULL,'%1')")
                   .arg(tableCode));
    }
    else {
        query.exec(QString("INSERT INTO main VALUES(%1,'%2')")
                   .arg(id).arg(tableCode));
    }
}

void Tables::insertValuesIntoDetails(int id, QString wojewodztwo, QString powiat, QString miasto)
{
    QSqlQuery query;

    if (id == -1) {
        /* It's time for auto increment function */
        query.exec(QString("INSERT INTO details VALUES(NULL,'%1','%2','%3')")
                   .arg(wojewodztwo).arg(powiat).arg(miasto));
    }
    else {
        query.exec(QString("INSERT INTO details VALUES(%1,'%2','%3','%4')")
                   .arg(id).arg(wojewodztwo).arg(powiat).arg(miasto));
    }
}

int Tables::getIdsNumber()
{
    QSqlQuery query;

    query.exec(QString("SELECT COUNT(id) FROM main"));
    query.next();
    int result = query.value(0).toInt();

    return result;
}

QString Tables::getTableCodeFromId(int id)
{
    QSqlQuery query;

    query.exec(QString("select tableCode from main where id = %1")
               .arg(id));
    query.next();
    QString result = query.value(0).toString();

    return result;
}

QString Tables::getWojewodztwoFromId(int id)
{
    QSqlQuery query;

    query.exec(QString("select wojewodztwo from details where id = %1")
               .arg(id));
    query.next();
    QString result = query.value(0).toString();

    return result;
}

QString Tables::getPowiatFromId(int id)
{
    QSqlQuery query;

    query.exec(QString("select powiat from details where id = %1")
               .arg(id));
    query.next();
    QString result = query.value(0).toString();

    return result;
}

QString Tables::getMiastoFromId(int id)
{
    QSqlQuery query;

    query.exec(QString("select miasto from details where id = %1")
               .arg(id));
    query.next();
    QString result = query.value(0).toString();

    return result;
}

void Tables::loadDataToModel()
{
    PlateItem *item;
    int num = getIdsNumber();

    for (int i = 0; i < num; i++) {
        item = new PlateItem(getTableCodeFromId(i), getWojewodztwoFromId(i));
        item->setPowiat(getPowiatFromId(i));
        item->setMiasto(getMiastoFromId(i));
        model->appendRow(item);
    }
}

void Tables::tabliceTymczasowe()
{
    PlateItem *item;
    QString data[16];
    data[0] = "B";
    data[1] = "C";
    data[2] = "D";
    data[3] = "E";
    data[4] = "F";
    data[5] = "G";
    data[6] = "K";
    data[7] = "L";
    data[8] = "N";
    data[9] = "O";
    data[10] = "P";
    data[11] = "R";
    data[12] = "S";
    data[13] = "T";
    data[14] = "W";
    data[15] = "Z";
    QString name[16];
    name[0] = "podlaskie";
    name[1] = "kujawsko-pomorskie";
    name[2] = QString::fromUtf8("dolnośląskie");
    name[3] = QString::fromUtf8("łódzkie");
    name[4] = "lubuskie";
    name[5] = "pomorskie";
    name[6] = QString::fromUtf8("małopolskie");
    name[7] = "lubelskie";
    name[8] = QString::fromUtf8("warmińsko-mazurskie");
    name[9] = "opolskie";
    name[10] = "wielkopolskie";
    name[11] = "podkarpackie";
    name[12] = QString::fromUtf8("śląskie");
    name[13] = QString::fromUtf8("świętokrzyskie");
    name[14] = "mazowieckie";
    name[15] = "zachodniopomorskie";

    for (int j = 0; j < 16; j++)
    for (int i = 0; i < 10; i++) {
        item = new PlateItem(data[j] + QString::number(i), name[j]);
        item->setPowiat("Tablica tymczasowa");
        item->setMiasto("<t_tymcz>");
        model->appendRow(item);
    }
}
