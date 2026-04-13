#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDirIterator>  // Added this
#include <QDebug>        // Added this
#include "reservationmanager.h"
using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // --- DETECTIVE CODE START ---
    qDebug() << "--- Checking Internal Resource Tree ---";
    QDirIterator it(":", QDirIterator::Subdirectories);
    while (it.hasNext()) {
        qDebug() << it.next();
    }
    qDebug() << "---------------------------------------";
    // --- DETECTIVE CODE END ---

    ReservationManager resManager;
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("resManager", &resManager);

    const QUrl url(u"qrc:/qt/qml/QuickDinner/Main.qml"_s);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        qDebug() << "CRITICAL: Engine failed to load Main.qml!";
    }

    return app.exec();
}
