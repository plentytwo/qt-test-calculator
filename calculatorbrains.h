#ifndef CALCULATORBRAINS_H
#define CALCULATORBRAINS_H

#include <QObject>
#include <QString>
#include <qqml.h>
#include <QTranslator>

#include <cmath>
#include <sstream>
#include <string>
#include <iostream>

enum Mode
{
    DEC,
    HEX
};

class CalculatorBrains : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString primaryValue READ primaryValue WRITE setPrimaryValue NOTIFY primaryValueChanged)
    Q_PROPERTY(QString secondaryValue READ secondaryValue WRITE setSecondaryValue NOTIFY secondaryValueChanged)

public:
    CalculatorBrains();

    QString primaryValue();
    void setPrimaryValue(const QString& value);

    QString secondaryValue();
    void setSecondaryValue(const QString& value);

signals:
    void primaryValueChanged();
    void secondaryValueChanged();

public slots:
    void pushValue(QString key);
    void pushSymbol(QString key);
    void pushCommand(QString key);
    void pushTypeChange(QString key);
    void solve();

    Q_INVOKABLE void setLanguage(QString lang);

private:

    const int DEC_lengthLimit = 8;
    const int HEX_lengthLimit = 6;

    const double DEC_precision = 0.0000001;

    std::string primary;
    std::string secondary;

    Mode mode;
    char operation;

    QString m_primaryValue;
    QString m_secondaryValue;
};

#endif // CALCULATORBRAINS_H
