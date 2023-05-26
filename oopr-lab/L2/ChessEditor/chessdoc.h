#ifndef CHESSDOC_H
#define CHESSDOC_H

#include <QObject>
#include <chesssquare.h>

class ChessDoc : public QObject
{
    Q_OBJECT
public:
    explicit ChessDoc(QObject *parent = nullptr);

    ChessSquare board[8][8];

    void load(QString file);
    void save(QString file);

signals:

    void chessDataChanged();

};

#endif // CHESSDOC_H
