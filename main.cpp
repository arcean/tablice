#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>
#include <QtOpenGL/QGLWidget>
#include <MDeclarativeCache>
#include <QtCore/QtGlobal>

#include "tables.h"
#include "listmodel.h"
#include "plateitem.h"

#include <QDebug>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication* app = MDeclarativeCache::qApplication(argc, argv);
    QDeclarativeView* view = MDeclarativeCache::qDeclarativeView();
    app->setOrganizationName("arcean");
    app->setOrganizationDomain("arcean.com");
    app->setApplicationName("tablice");

    Tables tables;
    ListModel *plates = new ListModel(new PlateItem, qApp);
    plates->searchModel = new ListModel(new PlateItem, qApp);
    tables.setListModel(plates);

    QDeclarativeContext *context = view->rootContext();
    context->setContextProperty("Tables", &tables);
    context->setContextProperty("EmptyPlates", plates->searchModel);
    context->setContextProperty("Plates", plates);

    view->setViewport(new QGLWidget());
    qDebug() << "F: " << app->applicationFilePath();
    //view->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    //view->setMainQmlFile(QLatin1String("qml/tablice/main.qml"));
    view->setSource(QUrl::fromLocalFile("/opt/tablice/qml/tablice/main.qml"));

    //view->showExpanded();
    view->showFullScreen();

    return app->exec();
}
