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
echo "-> Téléchargement de l'image"
    docker pull maximegy/kali-desktop-cesi:latest

