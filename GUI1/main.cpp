#include "mainwindow.h"
#include <QApplication>

extern bool    submit,cancel;
extern bool    ReqA,ReqB,ReqC;
extern QString deviceA,deviceB,deviceC;
extern QString Address2ContactA,Address2ContactB,Address2ContactC;
extern QString ntA,ntB,ntC;
extern int     nt;
int main(int argc, char *argv[])
{
    nt=0;
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}
