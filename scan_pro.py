import scapy.all as scapy
import nmap
import datetime
import netifaces #pip install netifaces
import ipaddress

# Die Funktion get_mac_vendor und die mac_lookup-Initialisierung wurden entfernt.

def arp_scan(ip):
    print(f"[*] Phase 1: Finde aktive Geräte im Netzwerk {ip}...")
    arp_request = scapy.ARP(pdst=ip)
    broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")
    arp_request_broadcast = broadcast/arp_request
    answered_list = scapy.srp(arp_request_broadcast, timeout=2, verbose=False)[0]
    clients = [{"ip": element[1].psrc, "mac": element[1].hwsrc} for element in answered_list]
    print(f"[+] {len(clients)} Geräte gefunden.")
    return clients

def nmap_scan(ip):
    nm = nmap.PortScanner()
    try:
        nm.scan(str(ip), arguments='-sV -T4 --top-ports 100')
        hostname = nm[ip].hostname() if ip in nm and nm[ip].hostname() else "Nicht gefunden"
        open_ports_details = []
        if ip in nm and 'tcp' in nm[ip]:
            for port, port_data in nm[ip]['tcp'].items():
                if port_data['state'] == 'open':
                    details = {
                        'port': port,
                        'service': port_data.get('name', ''),
                        'version': f"{port_data.get('product', '')} {port_data.get('version', '')}".strip()
                    }
                    open_ports_details.append(details)
        return hostname, open_ports_details
    except Exception as e:
        print(f"[!] Fehler beim Scannen von {ip}: {e}")
        return "Fehler", []

def save_results_to_file(detailed_clients, network):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    filename = f"netzwerk_scan_pro_{timestamp}.txt"
    with open(filename, "w") as f:
        f.write(f"Detaillierter Scan für Netzwerk {network} vom {timestamp}\n")
        f.write("=" * 70 + "\n\n")
        if not detailed_clients:
            f.write("Keine aktiven Geräte im Netzwerk gefunden.\n")
            return
        for client in detailed_clients:
            f.write(f"IP-ADRESSE:    {client['ip']}\n")
            f.write(f"MAC-ADRESSE:   {client['mac']}\n")
            # Die Zeile für den Hersteller wurde entfernt.
            f.write(f"HOSTNAME:      {client['hostname']}\n")
            ports_info = client['ports']
            if not ports_info:
                f.write("OFFENE PORTS:  Keine\n")
            else:
                f.write("OFFENE PORTS:\n")
                f.write(f"  {'PORT':<10} {'SERVICE':<20} {'VERSION'}\n")
                f.write(f"  {'----':<10} {'-------':<20} {'-------'}\n")
                for port_data in ports_info:
                    port_str = f"{port_data['port']}/tcp"
                    f.write(f"  {port_str:<10} {port_data['service']:<20} {port_data['version']}\n")
            f.write("-" * 70 + "\n")
    print(f"\n[+] Ergebnisse wurden erfolgreich in '{filename}' gespeichert.")

def detect_network():
    try:
        gateways = netifaces.gateways()
        default_gateway = gateways.get('default', {}).get(netifaces.AF_INET)
        if not default_gateway: return None
        interface = default_gateway[1]
        addresses = netifaces.ifaddresses(interface)
        ipv4_info = addresses.get(netifaces.AF_INET)[0]
        ip_address = ipv4_info.get('addr')
        netmask = ipv4_info.get('netmask')
        network = ipaddress.IPv4Network(f"{ip_address}/{netmask}", strict=False)
        return str(network.network_address) + f"/{network.prefixlen}"
    except Exception:
        return None

if __name__ == "__main__":
    network_to_scan = detect_network()
    if network_to_scan:
        print(f"[+] Automatisches Netzwerk erkannt: {network_to_scan}")
        answer = input("Soll dieses Netzwerk gescannt werden? (J/n): ").lower()
        if answer not in ["", "j", "ja"]:
            network_to_scan = input("Bitte gib das zu scannende Netzwerk ein (z.B. 192.168.1.0/24): ")
    else:
        print("[!] Konnte kein Netzwerk automatisch erkennen.")
        network_to_scan = input("Bitte gib das zu scannende Netzwerk ein (z.B. 192.168.1.0/24): ")
    try:
        ipaddress.ip_network(network_to_scan)
    except ValueError:
        print("[!] Ungültige Netzwerkadresse. Bitte im Format x.x.x.x/yy eingeben.")
        exit()
    
    clients_found = arp_scan(network_to_scan)
    detailed_results = []
    
    if clients_found:
        print("\n[*] Phase 2: Sammle Details für jedes Gerät mit Nmap...")
        for i, client in enumerate(clients_found):
            ip, mac = client['ip'], client['mac']
            print(f"    -> Scanne Gerät {i+1}/{len(clients_found)}: {ip}")
            hostname, open_ports = nmap_scan(ip)
            # Die Zeile, die den Hersteller sucht, wurde entfernt.
            detailed_results.append({
                "ip": ip, "mac": mac,
                "hostname": hostname, "ports": open_ports,
            })
    
    if detailed_results:
        save_results_to_file(detailed_results, network_to_scan)
    else:
        print("\n[-] Scan abgeschlossen. Keine Geräte, für die Details gesammelt werden konnten.")