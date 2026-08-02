; base zone file for example.com
$TTL 2d    ; default TTL for zone
$ORIGIN example.com. ; base domain-name
; Start of Authority RR defining the key characteristics of the zone (domain)
@         IN      SOA   router root (
                                2026080201 ; serial number
                                12h        ; refresh
                                15m        ; update retry
                                3w         ; expiry
                                2h         ; minimum
                                )
; name server RR for the domain
           IN      NS      router.example.com.
router     IN      A       172.16.0.1
firewall   IN      A       172.16.0.99

client1    IN      A       172.16.1.11
client2    IN      A       172.16.2.22
client3    IN      A       172.16.3.33
client4    IN      A       172.16.4.44

server     IN      A       172.16.99.42

