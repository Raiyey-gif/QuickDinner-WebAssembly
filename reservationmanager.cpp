#include "reservationmanager.h"

// This signature MUST match the .h file exactly
ReservationManager::ReservationManager(QObject *parent) : QObject(parent)
{
    users.insert("admin", {"admin123", true});
}

int ReservationManager::availableSeats() const {
    return maksKursi - totalKursiTerpakai;
}

QVariantList ReservationManager::queueList() const {
    QVariantList list;
    ReservationNode* walker = headQueue;
    while(walker) {
        QVariantMap map;
        map["nama"] = walker->nama;
        map["jumlah"] = walker->jumlah;
        map["waktu"] = walker->tanggal + " " + walker->jam;
        list.append(map);
        walker = walker->next;
    }
    return list;
}

bool ReservationManager::registerUser(QString username, QString password) {
    if (users.contains(username) || username.isEmpty()) return false;
    users.insert(username, {password, false});
    return true;
}

bool ReservationManager::loginUser(QString username, QString password) {
    if (!users.contains(username)) return false;
    return users[username].password == password;
}

bool ReservationManager::tambahReservasi(QString nama, int jumlah, QString tgl, QString jam) {
    if (totalReservasi >= maksKapasitas || (totalKursiTerpakai + jumlah) > maksKursi) return false;

    ReservationNode* newNode = new ReservationNode{nama, jumlah, tgl, jam, nullptr};
    if (!headQueue) { headQueue = newNode; }
    else {
        ReservationNode* walker = headQueue;
        while(walker->next) walker = walker->next;
        walker->next = newNode;
    }
    totalReservasi++;
    totalKursiTerpakai += jumlah;
    emit dataChanged();
    return true;
}

void ReservationManager::prosesAntrean() {
    if (!headQueue) return;
    ReservationNode* temp = headQueue;
    headQueue = headQueue->next;
    temp->next = headStack;
    headStack = temp;
    totalReservasi--;
    emit dataChanged();
}
