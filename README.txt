INSTALLATION:
- modifier entrypoint.sh pour mettre login et password VPN
- creer l'image Docker avec script 0_build_image
- modifier script start*sh et stop*sh pour utiliser l'image créée
- demarrer le container docker avec VPN Corp avec script start*sh

Configuer un proxy localhost:3233 dans son Web Browser pour acceder aux sites internes via VPN

Je m'en sers aussi pour se connecter en SSH sur serveurs internes via corkscrew

Host osc
        hostname ssh.osc.mycorp.com
        serveraliveinterval 10
        user cpauliat
        proxycommand corkscrew localhost 3233 %h %p
        