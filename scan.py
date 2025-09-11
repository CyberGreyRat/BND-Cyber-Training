# Importiere die notwendigen Funktionen aus der Scapy-Bibliothek
import scapy.all as scapy
import datetime

def scan(ip):
    """
    Diese Funktion scannt das angegebene Netzwerk und gibt eine Liste der gefundenen Clients zurück.
    """
    # Erstelle eine ARP-Anfrage. Diese fragt "Wer hat diese IP-Adresse?".
    # pdst (packet destination) ist die IP-Adresse oder der IP-Bereich, den wir scannen wollen.
    arp_request = scapy.ARP(pdst=ip)

    # Erstelle einen Ethernet-Frame, um die ARP-Anfrage zu versenden.
    # Die Ziel-MAC-Adresse "ff:ff:ff:ff:ff:ff" ist die Broadcast-Adresse,
    # was bedeutet, die Anfrage wird an alle Geräte im Netzwerk gesendet.
    broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")

    # Kombiniere den Ethernet-Frame und die ARP-Anfrage zu einem einzigen Paket.
    arp_request_broadcast = broadcast/arp_request

    # Sende das Paket und empfange die Antworten.
    # Das Timeout von 1 Sekunde sorgt dafür, dass wir nicht ewig auf nicht antwortende Geräte warten.
    # "verbose=False" unterdrückt unnötige Ausgaben in der Konsole.
    answered_list = scapy.srp(arp_request_broadcast, timeout=1, verbose=False)[0]

    # Erstelle eine leere Liste, um die Ergebnisse zu speichern.
    clients_list = []
    for element in answered_list:
        # Extrahiere die IP-Adresse (psrc) und die MAC-Adresse (hwsrc) aus der Antwort.
        client_dict = {"ip": element[1].psrc, "mac": element[1].hwsrc}
        clients_list.append(client_dict)
    
    return clients_list

def save_results_to_file(clients_list):
    """
    Diese Funktion speichert die Scan-Ergebnisse in einer Textdatei.
    """
    # Hole das aktuelle Datum und die Uhrzeit für den Dateinamen.
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    filename = f"netzwerk_scan_{timestamp}.txt"

    with open(filename, "w") as f:
        f.write(f"Scan-Ergebnis vom {timestamp}\n")
        f.write("-----------------------------------------\n")
        if not clients_list:
            f.write("Keine aktiven Geräte im Netzwerk gefunden.\n")
        else:
            # Schreibe eine Kopfzeile für die Tabelle.
            f.write(f"{'IP-ADRESSE':<20}{'MAC-ADRESSE':<20}\n")
            f.write("-----------------------------------------\n")
            for client in clients_list:
                f.write(f"{client['ip']:<20}{client['mac']:<20}\n")
        f.write("-----------------------------------------\n")
    
    print(f"[+] Ergebnisse wurden in der Datei '{filename}' gespeichert.")


# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# HAUPTPROGRAMM
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
if __name__ == "__main__":
    
    # !!! WICHTIG: Passe diese Zeile an dein Netzwerk an !!!
    # Die meisten Heimnetzwerke nutzen 192.168.1.0/24 oder 192.168.178.0/24 (Fritz!Box).
    # Finde deine IP-Adresse heraus (z.B. mit "ipconfig" bei Windows oder "ifconfig" bei Linux/Mac)
    # und ersetze die ersten drei Blöcke entsprechend. "/24" scannt das gesamte Subnetz.
    network_to_scan = "192.168.0.0/24" 
    
    print(f"[*] Scanne das Netzwerk {network_to_scan}...")
    
    scan_result = scan(network_to_scan)
    
    if scan_result:
        save_results_to_file(scan_result)
    else:
        print("[-] Keine aktiven Geräte gefunden.")

    print("[*] Scan abgeschlossen.")