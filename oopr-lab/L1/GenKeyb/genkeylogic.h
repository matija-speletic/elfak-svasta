#ifndef GENKEYLOGIC_H
#define GENKEYLOGIC_H

#include <QObject>

class GenKeyLogic : public QObject
{
    Q_OBJECT

    QString stanjeDispleja;

public:
    explicit GenKeyLogic(QObject *parent = nullptr);

    void doCommand(QString);

signals:
    void dispChanged(QString);

};

#endif // GENKEYLOGIC_H
