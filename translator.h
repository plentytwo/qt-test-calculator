#ifndef TRANSLATOR2_H
#define TRANSLATOR2_H

#include <QtGui>
#include <QQuickView>

class Translator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)

public:
    Translator();

    QString getEmptyString();

    Q_INVOKABLE void selectLanguage(QString language);

signals:
    void languageChanged();

private:
    QTranslator *fr_translator;
    QTranslator *de_translator;
};

#endif // TRANSLATOR2_H
