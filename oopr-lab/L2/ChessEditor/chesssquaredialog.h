#ifndef CHESSSQUAREDIALOG_H
#define CHESSSQUAREDIALOG_H

#include <QDialog>
#include <chesssquare.h>

namespace Ui {
class ChessSquareDialog;
}

class ChessSquareDialog : public QDialog
{
    Q_OBJECT
    ChessSquare*sqr;

public:
    explicit ChessSquareDialog(ChessSquare* sqr,QWidget *parent = nullptr);
    ~ChessSquareDialog();

private slots:
    void on_buttonBox_accepted();

private:
    Ui::ChessSquareDialog *ui;
    void fromObjectToControls();
    void fromControlsToObject();
};

#endif // CHESSSQUAREDIALOG_H
