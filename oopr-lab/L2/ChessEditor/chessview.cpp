#include "chessview.h"
#include <QPainter>
#include "chesssquaredialog.h"
#include <QMessageBox>

ChessView::ChessView(QWidget *parent) : QWidget(parent)
{
    QObject::connect(&this->doc,SIGNAL(doc.chessDataChanged()),this,SLOT(repaint()));
}

void ChessView::paintEvent(QPaintEvent *ev)
{
    QPainter p(this);
    drawChessboard(&p);
}

void ChessView::drawChessboard(QPainter *p)
{
    int rDim=((height()<width()?height():width())-100)/8;
    int startX=(width()-8*rDim)/2;
    int startY=(height()-8*rDim)/2-25;
    QImage img;
    img.load(":/new/prefix1/icons/download.png");
    int imgXDim=img.width()/6;
    int imgYDim=img.height()/2;

    //the board
    for(int i=0;i<8;i++)
    {
        for(int j=0;j<8;j++)
        {
            (i+j)%2==0?p->setBrush(QColor::fromRgb(252,204,116)):p->setBrush(QColor::fromRgb(87,58,46));
            p->drawRect(startX+i*rDim,startY+j*rDim,rDim,rDim);
            if(!doc.board[j][i].isEmpty)
                //p->drawImage(QRect(startX+i*rDim,startY+j*rDim,rDim,rDim),img,
                  //           QRect(0,0,imgXDim,imgYDim));
                p->drawImage(QRect(startX+i*rDim,startY+j*rDim,rDim,rDim),img,
                             QRect(imgXDim*doc.board[j][i].figureType,imgYDim*doc.board[j][i].figureColor,imgXDim,imgYDim));
        }
    }
    QFont font("Helvetica");
    font.setPixelSize(rDim/2);
    p->setFont(font);
    for(int i=1;i<9;i++)
    {
        p->drawText(startX-rDim/2,startY+10+(i-1)*rDim,rDim,rDim,0,QString("%1").arg(i));
    }
    for(int i=1;i<9;i++)
    {
        char c='A'+i-1;
        p->drawText(startX+10+(i-1)*rDim,startY+rDim*8,rDim,rDim,0,QString("%1").arg(c));
    }
}

void ChessView::mouseDoubleClickEvent(QMouseEvent *e)
{
   if ( e->button() == Qt::LeftButton )
   {
       int rDim=((height()<width()?height():width())-100)/8;
       int startX=(width()-8*rDim)/2;
       int startY=(height()-8*rDim)/2-25;
       int mouseX=e->pos().x(),mouseY=e->pos().y();
       if(mouseX>startX&&mouseY>startY&&mouseX<startX+8*rDim&&mouseY<startY+8*rDim)
       {
           int x=(mouseX-startX)/rDim;
           int y=(mouseY-startY)/rDim;
           QString aux="%1 %2";
           aux=aux.arg(x).arg(y);
           //QMessageBox::warning(this, windowTitle(),aux , "Ok");
           ChessSquareDialog dlg(&(doc.board[y][x]));
           dlg.exec();
           emit doc.chessDataChanged();
       }

   }
}

