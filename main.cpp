#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>

#include "calculatorbrains.h"
#include "translator.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<CalculatorBrains>("com.qt.calculatorbrains", 1, 0, "CalculatorBrains");
    qmlRegisterType<Translator>("com.qt.texttranslator", 1, 0, "TextTranslator");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
