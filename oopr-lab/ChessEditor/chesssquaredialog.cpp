#include "chesssquaredialog.h"
#include "ui_chesssquaredialog.h"

ChessSquareDialog::ChessSquareDialog(ChessSquare* sqr,QWidget *parent) :
    QDialog(parent),
    ui(new Ui::ChessSquareDialog),
    sqr(sqr)
{
    ui->setupUi(this);
    ui->cbColor->addItem("Black");
    ui->cbColor->addItem("White");
    ui->cbType->addItem("King");
    ui->cbType->addItem("Queen");
    ui->cbType->addItem("Bishop");
    ui->cbType->addItem("Knight");
    ui->cbType->addItem("Rook");
    ui->cbType->addItem("Pawn");
    fromObjectToControls();
}

ChessSquareDialog::~ChessSquareDialog()
{
    delete ui;
}

void ChessSquareDialog::fromObjectToControls()
{
    ui->cbIsEmpty->setChecked(sqr->isEmpty);
    ui->cbColor->setCurrentIndex(sqr->figureColor);
    ui->cbType->setCurrentIndex(sqr->figureType);
}

void ChessSquareDialog::fromControlsToObject()
{
    sqr->isEmpty=ui->cbIsEmpty->checkState();
    sqr->figureColor=ui->cbColor->currentIndex();
    sqr->figureType=ui->cbType->currentIndex();
}

void ChessSquareDialog::on_buttonBox_accepted()
{
    fromControlsToObject();
}

