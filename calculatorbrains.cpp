#include "calculatorbrains.h"

CalculatorBrains::CalculatorBrains()
{
    mode = DEC;
}

void CalculatorBrains::pushValue(QString key)
{
    if ((mode == DEC && primary.length() == DEC_lengthLimit) ||
        (mode == HEX && primary.length() == HEX_lengthLimit)) return;

    if (key == "." && primary.find('.') != std::string::npos) return;

    primary += key.toStdString()[0];

    setPrimaryValue(QString::fromUtf8(primary.c_str()));

}

void CalculatorBrains::pushSymbol(QString sym)
{
    if (primary.length() == 0)
        return;

    if (secondary.length() > 0)
    {
        operation = sym.toStdString()[0];
        setSecondaryValue(QString::fromUtf8(secondary.c_str()) + ' ' + sym);
    }
    else
    {
        if (primary.back() == '.')
            primary.pop_back();

        operation = sym.toStdString()[0];
        secondary = primary;
        primary = "";

        setPrimaryValue(QString::fromUtf8(primary.c_str()));
        setSecondaryValue(QString::fromUtf8(secondary.c_str()) + ' ' + sym);
    }
}

void CalculatorBrains::pushCommand(QString cmd)
{
    if (cmd == "CE")
    {
        if (primary.length() > 0)
            primary.pop_back();

        setPrimaryValue(QString::fromUtf8(primary.c_str()));
    }
    else if (cmd == "C")
    {
        operation = 0;
        primary = "";
        secondary = "";

        setPrimaryValue("");
        setSecondaryValue("");
    }
}

void CalculatorBrains::pushTypeChange(QString key)
{
    pushCommand("C");

    if (key == "DEC")
        mode = DEC;
    else if (key == "HEX")
        mode = HEX;
}

void CalculatorBrains::solve()
{
    if (secondary.length() == 0)
        return;

    if (operation == 0)
        return;

    if (mode == DEC)
    {
        double firstVal = std::stod(secondary);
        double secondVal = std::stod(primary);
        double result;

        if (operation == '/')
            result = firstVal / secondVal;
        else if (operation == '*')
            result = firstVal * secondVal;
        else if (operation == '-')
            result = firstVal - secondVal;
        else if (operation == '+')
            result = firstVal + secondVal;

        setPrimaryValue(QString::number(result));
    }
    else if (mode == HEX)
    {
        long firstVal = std::stol(secondary, 0, 16);
        long secondVal = std::stol(primary, 0, 16);
        long long result;

        if (operation == '/')
            result = firstVal / secondVal;
        else if (operation == '*')
            result = firstVal * secondVal;
        else if (operation == '-')
            result = firstVal - secondVal;
        else if (operation == '+')
            result = firstVal + secondVal;

        std::stringstream valStream;
        valStream << std::hex << result;

        setPrimaryValue(QString::fromUtf8(valStream.str().c_str()));
    }

    setSecondaryValue(QString::fromUtf8(secondary.c_str()) + ' ' + operation + ' ' + QString::fromUtf8(primary.c_str()) + " =");

    primary = "";
    secondary = "";
    operation = 0;
}

Q_INVOKABLE void CalculatorBrains::setLanguage(QString lang)
{

}

QString CalculatorBrains::primaryValue()
{
    return m_primaryValue;
}

void CalculatorBrains::setPrimaryValue(const QString &value)
{
    m_primaryValue = value;
    emit primaryValueChanged();
}

QString CalculatorBrains::secondaryValue()
{
    return m_secondaryValue;
}

void CalculatorBrains::setSecondaryValue(const QString &value)
{
    m_secondaryValue = value;
    emit secondaryValueChanged();
}
