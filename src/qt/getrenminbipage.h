#ifndef GETVERICOINPAGE_H
#define GETVERICOINPAGE_H

#include <QWidget>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QByteArray>
#include <QTimer>

namespace Ui {
    class GetRenminbiPage;
}
class ClientModel;
class WalletModel;

QT_BEGIN_NAMESPACE
class QModelIndex;
QT_END_NAMESPACE

/** Trade page widget */
class GetRenminbiPage : public QWidget
{
    Q_OBJECT

public:
    explicit GetRenminbiPage(QWidget *parent = 0);
    ~GetRenminbiPage();

    void setModel(ClientModel *clientModel);
    void setModel(WalletModel *walletModel);

public slots:

// signals:

private:
    Ui::GetRenminbiPage *ui;
    ClientModel *clientModel;
    WalletModel *walletModel;

private slots:

};

#endif // GETVERICOINPAGE_H
