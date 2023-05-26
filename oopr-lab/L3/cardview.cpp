#include "cardview.h"
#include <QPainter>

CardView::CardView(QWidget *parent) : QWidget(parent)
{
    img.load(":/new/prefix1/res/download.png");
    currentCardNum=0;
    connect(&timer,SIGNAL(timeout()),this,SLOT(onCardTimer()));
    setFocusPolicy(Qt::StrongFocus);
}

CardView::~CardView()
{
    timer.stop();
    disconnect(&timer,nullptr,nullptr,nullptr);
}

void CardView::paintEvent(QPaintEvent *)
{
    drawCards();
}

void CardView::drawCards()
{
    QPainter p(this);
    p.setBrush(QColor(0,119,0));
    p.drawRect(0,0,width(),height());

    int cardW=img.width()/13,cardH=img.height()/4;
    int offset=50,spaceBetweenCards=15;

    for(int i=0;i<currentCardNum;i++)
    {
        p.drawImage(
             QRect(width()-cardW-offset-i*spaceBetweenCards,height()-cardH-offset,cardW,cardH),
             img,
             QRect(((i+7)%13)*cardW,2*cardH,cardW,cardH)
        );
    }

}

void CardView::keyPressEvent(QKeyEvent * event)
{
    if(event->key()==Qt::Key_D)
    {
        timer.start(100);
    }

}

void CardView::onCardTimer()
{
    currentCardNum=(currentCardNum+1)%14;
    this->repaint();
    if(currentCardNum==13)
        timer.stop();
}
