#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QFileDialog>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_actionSave_Chessboard_triggered()
{
    //save clicked
    QString filePath = QFileDialog::getSaveFileName(this, QString(), QString(), "Chessboard Text Document (*.txt);;All Files (*.*)");
    if(!filePath.isEmpty())
    {
        ui->centralwidget->doc.save(filePath);
    }
}


void MainWindow::on_actionOpen_Chessboard_triggered()
{
    //open clicked
    QString filePath = QFileDialog::getOpenFileName(this, QString(), QString(), "Chessboard Text Document (*.txt);;All Files (*.*)");
    if(!filePath.isEmpty())
    {
        ui->centralwidget->doc.load(filePath);
    }
}

