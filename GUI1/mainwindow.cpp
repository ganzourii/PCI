#include "mainwindow.h"
#include "ui_mainwindow.h"

bool    submit,cancel;
bool    ReqA,ReqB,ReqC;
QString deviceA,deviceB,deviceC;
QString Address2ContactA,Address2ContactB,Address2ContactC;
QString ntA,ntB,ntC;
QString datain="10101010101010101010101010101010";
int nt;

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()            //Submit button
{
    //submit = !submit;
    if(ui->checkBox->isChecked()){
        ui->textBrowser->setText("A");
        if(Address2ContactA=="B"||Address2ContactA=="b"){
            nt=ntA.toInt();
            if(nt==1)ui->textBrowser_8->setText(datain);
            else if(nt==2){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
            }
            else if(nt==3){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
            }
            else if(nt==4){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
                ui->textBrowser_11->setText(datain);
            }
            else if(nt==5){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
                ui->textBrowser_11->setText(datain);
                ui->textBrowser_12->setText(datain);
            }
            else if(nt==6){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
                ui->textBrowser_11->setText(datain);
                ui->textBrowser_12->setText(datain);
                ui->textBrowser_13->setText(datain);
            }
        }
        else if(Address2ContactA=="C"||Address2ContactA=="c"){
            nt=ntA.toInt();
            if(nt==1)ui->textBrowser_14->setText(datain);
            else if(nt==2){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
            }
            else if(nt==3){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
            }
            else if(nt==4){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
                ui->textBrowser_17->setText(datain);
            }
            else if(nt==5){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
                ui->textBrowser_17->setText(datain);
                ui->textBrowser_18->setText(datain);
            }
            else if(nt==6){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
                ui->textBrowser_17->setText(datain);
                ui->textBrowser_18->setText(datain);
                ui->textBrowser_19->setText(datain);
            }
        }

    }
    else if(ui->checkBox_2->isChecked()){
        ui->textBrowser->setText("B");
        if(Address2ContactB=="A"||Address2ContactB=="a"){
            nt=ntB.toInt();
            if(nt==1)ui->textBrowser_2->setText(datain);
            else if(nt==2){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
            }
            else if(nt==3){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
            }
            else if(nt==4){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
                ui->textBrowser_5->setText(datain);
            }
            else if(nt==5){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
                ui->textBrowser_5->setText(datain);
                ui->textBrowser_6->setText(datain);
            }
            else if(nt==6){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
                ui->textBrowser_5->setText(datain);
                ui->textBrowser_6->setText(datain);
                ui->textBrowser_7->setText(datain);
            }
        }
        else if(Address2ContactB=="C"||Address2ContactB=="c"){
            nt=ntB.toInt();
            if(nt==1)ui->textBrowser_14->setText(datain);
            else if(nt==2){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
            }
            else if(nt==3){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
            }
            else if(nt==4){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
                ui->textBrowser_17->setText(datain);
            }
            else if(nt==5){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
                ui->textBrowser_17->setText(datain);
                ui->textBrowser_18->setText(datain);
            }
            else if(nt==6){
                ui->textBrowser_14->setText(datain);
                ui->textBrowser_15->setText(datain);
                ui->textBrowser_16->setText(datain);
                ui->textBrowser_17->setText(datain);
                ui->textBrowser_18->setText(datain);
                ui->textBrowser_19->setText(datain);
            }
        }
    }
    else if(ui->checkBox_3->isChecked()){
        ui->textBrowser->setText("C");
        if(Address2ContactC=="B"||Address2ContactC=="b"){
            nt=ntC.toInt();
            if(nt==1)ui->textBrowser_8->setText(datain);
            else if(nt==2){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
            }
            else if(nt==3){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
            }
            else if(nt==4){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
                ui->textBrowser_11->setText(datain);
            }
            else if(nt==5){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
                ui->textBrowser_11->setText(datain);
                ui->textBrowser_12->setText(datain);
            }
            else if(nt==6){
                ui->textBrowser_8->setText(datain);
                ui->textBrowser_9->setText(datain);
                ui->textBrowser_10->setText(datain);
                ui->textBrowser_11->setText(datain);
                ui->textBrowser_12->setText(datain);
                ui->textBrowser_13->setText(datain);
            }
        }
        else if(Address2ContactC=="A"||Address2ContactC=="a"){
            nt=ntC.toInt();
            if(nt==1)ui->textBrowser_2->setText(datain);
            else if(nt==2){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
            }
            else if(nt==3){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
            }
            else if(nt==4){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
                ui->textBrowser_5->setText(datain);
            }
            else if(nt==5){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
                ui->textBrowser_5->setText(datain);
                ui->textBrowser_6->setText(datain);
            }
            else if(nt==6){
                ui->textBrowser_2->setText(datain);
                ui->textBrowser_3->setText(datain);
                ui->textBrowser_4->setText(datain);
                ui->textBrowser_5->setText(datain);
                ui->textBrowser_6->setText(datain);
                ui->textBrowser_7->setText(datain);
            }
        }
    }
}

void MainWindow::on_checkBox_clicked()              //ReqA checkbox
{
    ReqA = !ReqA;
}

void MainWindow::on_checkBox_2_clicked()            //ReqB checkbox
{
    ReqB = !ReqB;
}

void MainWindow::on_checkBox_3_clicked()            //ReqC checkbox
{
    ReqC = !ReqC;
}

void MainWindow::on_textEdit_textChanged()          //Address to contact A
{
    Address2ContactA = ui->textEdit->toPlainText();
}

void MainWindow::on_textEdit_2_textChanged()        //Address to contact B
{
    Address2ContactB = ui->textEdit_2->toPlainText();
}

void MainWindow::on_textEdit_3_textChanged()        //Address to contact C
{
    Address2ContactC = ui->textEdit_3->toPlainText();
}

void MainWindow::on_textEdit_4_textChanged()        //no Data A
{
    ntA = ui->textEdit_4->toPlainText();
    //ui->textBrowser->setText(ntA);
}

void MainWindow::on_textEdit_5_textChanged()        //no. Data B
{
    ntB = ui->textEdit_5->toPlainText();
}

void MainWindow::on_textEdit_6_textChanged()        //no. Data C
{
    ntC = ui->textEdit_6->toPlainText();
}

void MainWindow::on_pushButton_2_clicked()          //Cancel button
{

}
