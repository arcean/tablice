#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>
#include <QtOpenGL/QGLWidget>
#include <MDeclarativeCache>
#include <QtCore/QtGlobal>

#include "tables.h"
#include "listmodel.h"
#include "plateitem.h"
#include "settings.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication* app = MDeclarativeCache::qApplication(argc, argv);
    QDeclarativeView* view = MDeclarativeCache::qDeclarativeView();
    app->setOrganizationName("arcean");
    app->setOrganizationDomain("arcean.com");
    app->setApplicationName("tablice");
    app->setApplicationVersion(APP_VERSION);

    Settings settings;
    Tables tables;
    ListModel *plates = new ListModel(new PlateItem, qApp);
    plates->searchModel = new ListModel(new PlateItem, qApp);
    plates->setSettings(&settings);
    tables.setListModel(plates);

    QDeclarativeContext *context = view->rootContext();
    context->setContextProperty("APP_VERSION", APP_VERSION);
    context->setContextProperty("Tables", &tables);
    context->setContextProperty("EmptyPlates", plates->searchModel);
    context->setContextProperty("Plates", plates);
    context->setContextProperty("Settings", &settings);

    view->setAttribute(Qt::WA_OpaquePaintEvent);
    view->setAttribute(Qt::WA_NoSystemBackground);
    view->viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
    view->viewport()->setAttribute(Qt::WA_NoSystemBackground);
    view->setSource(QUrl::fromLocalFile("/opt/tablice/qml/tablice/main.qml"));

    view->showFullScreen();

    return app->exec();
}
