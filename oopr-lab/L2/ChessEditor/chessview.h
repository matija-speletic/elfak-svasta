#ifndef CHESSVIEW_H
#define CHESSVIEW_H

#include <QWidget>
#include <chessdoc.h>
#include <QMouseEvent>

class ChessView : public QWidget
{
    Q_OBJECT
public:
    ChessDoc doc;

    explicit ChessView(QWidget *parent = nullptr);

    void paintEvent(QPaintEvent*);

    void drawChessboard(QPainter* p);

signals:

protected:
    void mouseDoubleClickEvent( QMouseEvent * e );

};

#endif // CHESSVIEW_H
