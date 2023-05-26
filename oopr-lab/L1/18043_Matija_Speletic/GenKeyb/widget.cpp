#include "widget.h"
#include "ui_widget.h"

Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);
    genKeyLogic=new GenKeyLogic(parent);

    connect(ui->btnTacka,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnPet,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnDva,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnProcenat,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnTri,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnJedan,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnStrelica,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnSest,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnX,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnA,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnDevet,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnOsam,SIGNAL(clicked()),this,SLOT(onBtnClicked()));
    connect(ui->btnNula,SIGNAL(clicked()),this,SLOT(onBtnClicked()));

    connect(this->genKeyLogic,SIGNAL(dispChanged(QString)),this,SLOT(onDispChanged(QString)));
}

Widget::~Widget()
{
    delete ui;
}

void Widget::onBtnClicked()
{
    QString textDugmeta=sender()->property("text").toString();
    genKeyLogic->doCommand(textDugmeta);
}

void Widget::onDispChanged(QString noviTekst)
{
    ui->txtDisplej->setText(noviTekst);
}

