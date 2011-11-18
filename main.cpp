#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtDeclarative>
#include <QtOpenGL/QGLWidget>

#include "tables.h"
#include "listmodel.h"
#include "plateitem.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setOrganizationName("arcean");
    app.setOrganizationDomain("arcean.com");
    app.setApplicationName("tablice");

    QmlApplicationViewer viewer;
    Tables tables;
    ListModel *plates = new ListModel(new PlateItem, qApp);
    plates->searchModel = new ListModel(new PlateItem, qApp);
    tables.setListModel(plates);

    QDeclarativeContext *context = viewer.rootContext();
    context->setContextProperty("Tables", &tables);
    context->setContextProperty("EmptyPlates", plates->searchModel);
    context->setContextProperty("Plates", plates);

    viewer.setViewport(new QGLWidget());
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/tablice/main.qml"));

    viewer.showExpanded();

    return app.exec();
}
