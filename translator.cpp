#include "translator.h"

Translator::Translator()
{
    fr_translator = new QTranslator(this);
    de_translator = new QTranslator(this);
}

QString Translator::getEmptyString()
{
    return "";
}

Q_INVOKABLE void Translator::selectLanguage(QString language)
{
    if(language == QString("fr")) {
        fr_translator->load(":/lang_fr.qm");
        qApp->installTranslator(fr_translator);
    }

    if(language == QString("de")) {
        de_translator->load(":/lang_de.qm");
        qApp->installTranslator(de_translator);
    }

    if(language == QString("en")) {
        qApp->removeTranslator(fr_translator);
        qApp->removeTranslator(de_translator);
    }

    emit languageChanged();
}
