#ifndef CARDVIEW_H
#define CARDVIEW_H

#include <QWidget>
#include <QImage>
#include <QTimer>
#include <QKeyEvent>


class CardView : public QWidget
{
    Q_OBJECT

private:
    QImage img;
    QTimer timer;
    int currentCardNum;

public:
    explicit CardView(QWidget *parent = nullptr);
    ~CardView();

    void drawCards();

protected:
    void keyPressEvent(QKeyEvent *event);
    void paintEvent(QPaintEvent*);


signals:

public slots:
    void onCardTimer();

};

#endif // CARDVIEW_H
