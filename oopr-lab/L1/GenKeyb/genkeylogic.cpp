#include "genkeylogic.h"

GenKeyLogic::GenKeyLogic(QObject *parent) : QObject(parent)
{
    stanjeDispleja="";
}

void GenKeyLogic::doCommand(QString cmd)
{
    stanjeDispleja+=cmd;
    emit dispChanged(stanjeDispleja);
}
