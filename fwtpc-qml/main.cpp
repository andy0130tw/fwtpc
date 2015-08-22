#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFont>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QFont font;
    font.setFamily("思源黑體, 'Noto Sans CJK TC', Roboto");
    font.setPixelSize(14);
    app.setFont(font);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
