#ifndef RESERVATIONMANAGER_H
#define RESERVATIONMANAGER_H

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QMap>

struct ReservationNode {
    QString nama;
    int jumlah;
    QString tanggal;
    QString jam;
    ReservationNode* next = nullptr;
};

struct UserAccount {
    QString password;
    bool isAdmin;
};

class ReservationManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(int availableSeats READ availableSeats NOTIFY dataChanged)
    Q_PROPERTY(QVariantList queueList READ queueList NOTIFY dataChanged)

public:
    // The signature MUST have (QObject *parent)
    explicit ReservationManager(QObject *parent = nullptr);

    Q_INVOKABLE bool registerUser(QString username, QString password);
    Q_INVOKABLE bool loginUser(QString username, QString password);
    Q_INVOKABLE bool tambahReservasi(QString nama, int jumlah, QString tgl, QString jam);
    Q_INVOKABLE void prosesAntrean();

    int availableSeats() const;
    QVariantList queueList() const;

signals:
    void dataChanged();

private:
    ReservationNode* headQueue = nullptr;
    ReservationNode* headStack = nullptr;
    QMap<QString, UserAccount> users;
    int totalReservasi = 0;
    int totalKursiTerpakai = 0;
    const int maksKapasitas = 10;
    const int maksKursi = 40;
};

#endif
