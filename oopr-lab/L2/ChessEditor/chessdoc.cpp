#include "chessdoc.h"
#include <QFile>

ChessDoc::ChessDoc(QObject *parent) : QObject(parent)
{
    for (int i=0;i<8;i++)
    {
        for(int j=0;j<8;j++)
        {
            board[i][j].squareColor=(i+j)%2;
        }
    }
}

void ChessDoc::load(QString file)
{
    QFile f(file);
    if(!f.open(QIODevice::ReadOnly))
        qFatal("Could not open file");
    QString fileText=QString::fromUtf8(f.readAll());
    f.close();

    QStringList lines=fileText.split("\n");
    for(int i=0;i<8;i++)
    {
        QStringList symbols=lines[i].split(",");
        for(int j=0;j<8;j++)
        {
            if(symbols[j].contains("-"))
                board[i][j].isEmpty=true;
            else
            {
                board[i][j].isEmpty=false;
                if((symbols[j])[0]=="B")
                    board[i][j].figureColor=0;
                else
                    board[i][j].figureColor=1;

                if((symbols[j])[1]== 'K')
                    board[i][j].figureType=0;
                else if((symbols[j])[1]== 'Q')
                    board[i][j].figureType=1;
                else if((symbols[j])[1]=='B')
                    board[i][j].figureType=2;
                else if((symbols[j])[1]== 'N')
                    board[i][j].figureType=3;
                else if((symbols[j])[1]== 'R')
                    board[i][j].figureType=4;
                else
                    board[i][j].figureType=5;
            }
        }
    }

    emit chessDataChanged();

}

void ChessDoc::save(QString file)
{
    QString fileText="";
    for (int i=0;i<8;i++)
    {
        for(int j=0;j<8;j++)
        {
            if(!board[i][j].isEmpty)
            {
                if(board[i][j].figureColor==0)
                    fileText.append("B");
                else
                    fileText.append("W");

                switch (board[i][j].figureType)
                {
                case 0:
                    fileText.append("K");
                    break;
                case 1:
                    fileText.append("Q");
                    break;
                case 2:
                    fileText.append("B");
                    break;
                case 3:
                    fileText.append("N");
                    break;
                case 4:
                    fileText.append("R");
                    break;
                case 5:
                    fileText.append("P");
                    break;
                }
            }
            else
                fileText.append("-");

            if(j==7)
                fileText.append("\n");
            else
                fileText.append(",");
        }
    }

    QFile f(file);
    if(!f.open(QIODevice::WriteOnly))
        qFatal("Could not open file");

    f.write(fileText.toUtf8());
    f.close();

}
