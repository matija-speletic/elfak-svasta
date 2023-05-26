#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <genkeylogic.h>

QT_BEGIN_NAMESPACE
namespace Ui { class Widget; }
QT_END_NAMESPACE

class Widget : public QWidget
{
    Q_OBJECT

    GenKeyLogic* genKeyLogic;

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

public slots:
    void onBtnClicked();
    void onDispChanged(QString);

private:
    Ui::Widget *ui;
};
#endif // WIDGET_H
