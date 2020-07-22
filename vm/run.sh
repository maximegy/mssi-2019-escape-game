#!/bin/bash

echo "Bonjour, bienvenue sur la VM docker de l'escape game."
echo "Le script que vous avez lancé est conçu pour fonctionner sur Debian OS"
echo "Avant de lancer ce script, assurez vous d'avoir une connection internet fonctionnelle"
read

clear
echo "#################################################################################"
echo "#                                                                               #"
echo "#                        INITIALISATION ET INSTALLATIONS                        #"
echo "#                                                                               #"
echo "#################################################################################"

echo "Ce script nécessite l'utilisation de docker"
echo "-> Vérification de l'installation de docker"
    sleep 2
    if [ `dpkg -l | grep 'docker-ce ' | awk '{print $1}'` != "ii" ]; then
        echo "** Docker n'est pas installé **"
        echo "-> Test de la connection internet en vue de son installation"
            sleep 2
            wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
            while [ ! -s /tmp/google.idx ]; do
                echo "** Pas de connection internet **"
                echo "-> Merci de faire les changements nécessaires"
                echo "-- Nouveau test dans 10 secondes --"
                sleep 10
                wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
            done
        echo "** Connection Internet OK **"
        echo "-> Installation de docker, l'opération peut prendre du temps"
            echo "-- Installation des utilitaires --"
                apt update &> /dev/null
                apt-get install -y \
                apt-transport-https \
                ca-certificates \
                curl \
                gnupg-agent \
                software-properties-common &> /dev/null
            echo "-- Ajout de la clé APT --"
                curl -fsSL https://download.docker.com/linux/debian/gpg &> /dev/null | apt-key add - &> /dev/null
            echo "-- Ajout du Répertoire APT --"
                add-apt-repository \
                "deb [arch=amd64] https://download.docker.com/linux/debian \
                $(lsb_release -cs) \
                stable" &> /dev/null
            echo "-- Installation du moteur Docker --"
                apt update &> /dev/null
                apt install -y docker-ce docker-ce-cli containerd.io &> /dev/null
            user=$(ls /home/)
            echo "-- Ajout des droits à l'utilisateur $user --"
                usermod -aG docker $user
    else
        echo "** Docker est bien installé **"
    fi

echo ""
echo "#################################################################################"
echo ""
echo "Ce script nécessite la dernière image de l'escape game"
echo "Verification de la présence de l'image"
    if [[ "$(docker images -q maximegy/kali-desktop-cesi:latest 2> /dev/null)" == "" ]]; then
        echo "** L'image n'est pas présente **"
        echo "-> Test de la connection internet en vue de son téléchargement"
            sleep 2
            wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
            while [ ! -s /tmp/google.idx ]; do
                echo "** Pas de connection internet **"
                echo "-> Merci de faire les changements nécessaires"
                echo "-- Nouveau test dans 10 secondes --"
                sleep 10
                wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
            done
        echo "** Connection Internet OK **"
        echo "-> Téléchargement de la dernière image"
            docker pull maximegy/kali-desktop-cesi:latest
    else
        echo "** L'image est déjà présente, pour la mettre à jour, connecter la machine à internet et utiliser le menu principal"
        sleep 2
    fi

while true; do
    clear
    echo ""
    echo "#################################################################################"
    echo "#                                                                               #"
    echo "#                                 MENU PRINCIPAL                                #"
    echo "#                                                                               #"
    echo "#################################################################################"
    echo ""
    echo "                Reset -------------------------------------- : 1"
    echo "                Connection au conteneur existant ----------- : 2"
    echo "                Redémarrer le conteneur -------------------- : 3"
    echo "                Télécharger la dernière image -------------- : 4"
    echo "                Arrêter et supprimer le conteneur ---------- : 5"
    echo "                Quitter ------------------------------------ : Q"
    read choix

    case $choix in
    1) #Reset
        echo "** Reset en cours ... **"
        echo "-> Stop container"
        docker stop pc-hacker
        echo "-> Delete container"
        docker rm pc-hacker
        echo "-> Launch New container"
        docker run -d -p 5900:5900 -p 6080:6080 --name pc-hacker --privileged -e RESOLUTION=1920x1080x24 -e ESCAPE_UTIL="/home/kali/escape/res/escape_f_utils" -e USER=kali -e PASSWORD=kaligator -e ROOT_PASSWORD=AzertyuiopROOT maximegy/kali-desktop-cesi:latest
        echo "-> Connection au Nouveau conteneur"
        docker exec -it pc-hacker bash -c 'echo $(tty) > /tmp/TTY_ADMIN && chown kali:kali /tmp/TTY_ADMIN && chown kali:kali $(tty) && bash'
    ;;
    2) # Connection au conteneur existant
        echo "** Connection au conteneur existant ...  **"
        docker exec -it pc-hacker bash -c 'echo $(tty) > /tmp/TTY_ADMIN && chown kali:kali /tmp/TTY_ADMIN && chown kali:kali $(tty) && bash'
    ;;
    3)
        echo "Redémarrage du conteneur"
        docker restart pc-hacker
    ;;
    4)
        echo "Téléchargement de la dernière version"
        docker pull maximegy/kali-desktop-cesi:latest
    ;;
    5)
        echo "Stop conteneur"
        docker stop pc-hacker
        echo "Suppression du conteneur"
        docker rm pc-hacker
    ;;
    [qQ] )
        echo "Aurevoir"
        break
    ;;
    *) echo "Entrée Invalide"
    ;;
    esac
done