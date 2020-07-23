#!/bin/bash

echo "Bonjour, bienvenue sur le pc de l'escape game."
echo "Le script que vous avez lancé est conçu pour fonctionner sur Raspbian OS avec le moteur de Terminal LXTerminal"
echo "Avant de lancer ce script, préparez une clé USB qui sera utilisée pour le jeu"
echo -n "Appuyer sur [Entrer] pour continuer"
read

clear
echo "#################################################################################"
echo "#                                                                               #"
echo "#                        INITIALISATION ET INSTALLATIONS                        #"
echo "#                                                                               #"
echo "#################################################################################"

echo "Ce script nécessite l'utilisation de xscreensaver"
echo "-> Vérification de l'installation de xscreensaver"
    sleep 2
    if [ `dpkg -l | grep 'xscreensaver ' | awk '{print $1}'` != "ii" ]; then
        echo "** XScreensaver n'est pas installé **"
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
        echo "-> Installation de xscreensaver, l'opération peut prendre du temps"
        apt update &> /dev/null
        apt install -y xscreensaver &> /dev/null
        echo "** L'installation de xscreensaver nécessite un redémarrage de la machine **"
        echo "-> Veuillez relancer ce script après le redémarrage."
        echo "-- La machine va redémarrer dans 5 secondes --"
        sleep 5
        reboot
    else
        echo "** XScreensaver est bien installé **"
    fi

echo ""
echo "#################################################################################"
echo ""
echo "Ce script nécessite l'utilisation de vnc-viewer"
echo "Verification de l'installation de vnc-viewer"
    sleep 2
    if [ `dpkg -l | grep 'vnc-viewer' | awk '{print $1}'` != "ii" ]; then
        echo "vnc-viewer n'est pas installé."
        echo "test de la connection internet en vue de son installation"
            sleep 2
            wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
            while [ ! -s /tmp/google.idx ]; do
                echo "Pas de connection internet"
                echo "Merci de faire les changements nécessaires"
                echo "Nouveau test dans 10 secondes"
                sleep 10
                wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
            done
        echo "Connection Internet OK"``
        echo "Installation de vnc-viewer, ça peut prendre du temps"
        apt update &> /dev/null
        apt install -y realvnc-vnc-viewer &> /dev/null
    else
        echo "vnc-viewer est bien installé"
    fi

    echo "verification de la configuration de vnc-viewer"
    vncfile="/home/pi/pc-hacker.vnc"
    if [ ! -e $vncfile ]; then
        echo "Le fichier de configuration n'existe pas"
        echo "Generation du fichier"
        cat > $vncfile <<EOF
ConnMethod=tcp
ConnTime=2020-07-07T15:55:14.329Z
EnableToolbar=0
Encryption=PreferOff
FriendlyName=pc-hacker
FullScreen=1
HideCloseAlert=1
Host=192.168.2.253:5900
Password=2185e92da90847f3720db5007174699a
RelativePtr=0
Uuid=d65a5d02-4106-46c7-a241-157a96cca8e1
WarnUnencrypted=0
EOF
        echo "La configuration a été générée"
    else
        echo "la configuration existe déjà"
    fi

echo ""
echo "#################################################################################"
echo ""
echo "Configuration de l'environnement de travail"
desktopconfig="/home/pi/.config/pcmanfm/LXDE-pi/desktop-items-0.conf"
terminalconfig="/home/pi/.config/lxterminal/lxterminal.conf"
panelconfig="/home/pi/.config/lxpanel/LXDE-pi/panels/panel"
echo "Configuration du Bureau"
cat > $desktopconfig <<EOF
[*]
wallpaper_mode=color
wallpaper_common=1
wallpaper=/usr/share/rpd-wallpaper/waterfall.jpg
desktop_bg=#000000
desktop_fg=#000000
desktop_shadow=#000000
desktop_font=PibotoLt 12
show_wm_menu=0
sort=mtime;ascending;
show_documents=0
show_trash=0
show_mounts=0
EOF

echo "Configuration du Terminal"
cat > $terminalconfig <<EOF
[general]
fontname=Monospace 10
selchars=-A-Za-z0-9,./?%&#:_
scrollback=1000
bgcolor=rgb(0,0,0)
fgcolor=rgb(115,210,22)
palette_color_0=rgb(0,0,0)
palette_color_1=rgb(170,0,0)
palette_color_2=rgb(0,170,0)
palette_color_3=rgb(170,85,0)
palette_color_4=rgb(0,0,170)
palette_color_5=rgb(170,0,170)
palette_color_6=rgb(0,170,170)
palette_color_7=rgb(170,170,170)
palette_color_8=rgb(85,85,85)
palette_color_9=rgb(255,85,85)
palette_color_10=rgb(85,255,85)
palette_color_11=rgb(255,255,85)
palette_color_12=rgb(85,85,255)
palette_color_13=rgb(255,85,255)
palette_color_14=rgb(85,255,255)
palette_color_15=rgb(255,255,255)
color_preset=Custom
disallowbold=false
cursorblinks=false
cursorunderline=false
audiblebell=false
tabpos=top
geometry_columns=80
geometry_rows=24
hidescrollbar=true
hidemenubar=true
hideclosebutton=true
hidepointer=false
disablef10=false
disablealt=false
disableconfirm=false

[shortcut]
new_window_accel=<Primary><Shift>n
new_tab_accel=<Primary><Shift>t
close_tab_accel=<Primary><Shift>w
close_window_accel=<Primary><Shift>q
copy_accel=<Primary><Shift>c
paste_accel=<Primary><Shift>v
name_tab_accel=<Primary><Shift>i
previous_tab_accel=<Primary>Page_Up
next_tab_accel=<Primary>Page_Down
move_tab_left_accel=<Primary><Shift>Page_Up
move_tab_right_accel=<Primary><Shift>Page_Down
zoom_in_accel=<Primary><Shift>plus
zoom_out_accel=<Primary><Shift>underscore
zoom_reset_accel=<Primary><Shift>parenright
EOF

echo "Configuration de la barre des tâches"
cat > $panelconfig <<EOF
Global {
  edge=bottom
  align=left
  margin=0
  widthtype=percent
  width=100
  height=29
  transparent=1
  tintcolor=#000000
  alpha=255
  autohide=0
  heightwhenhidden=2
  setdocktype=1
  setpartialstrut=1
  usefontcolor=0
  fontsize=12
  fontcolor=#ffffff
  usefontsize=0
  background=0
  backgroundfile=/usr/share/lxpanel/images/background.png
  iconsize=16
  monitor=0
  point_at_menu=0
}
Plugin {
  type=menu
  Config {
    padding=4
    image=start-here
    system {
    }
    separator {
    }
    item {
      name=Run...
      image=system-run
      command=run
    }
    separator {
    }
    item {
      name=Shutdown...
      image=system-shutdown
      command=logout
    }
  }
}
EOF


echo ""
echo "#################################################################################"
echo ""
echo "Installation des Scripts"
scriptwait="/home/pi/wait.sh"
scriptopen="/home/pi/opensession.sh"
echo "-> Script Wait.sh pour informer le joueur du verrouillage de session car la clé n'a pas été branchée"
if [ ! -e $scriptwait ]; then
cat > $scriptwait <<EOF
#!/bin/bash
DeviceIdFile=/home/pi/Device.id
DeviceId=`cat $DeviceIdFile`

while true; do
#echo "ID : "
#echo $DeviceId
#echo "Grep : "
#echo `lsusb | grep $DeviceId | wc -l | xargs`
#sleep 10
if [ `lsusb | grep $DeviceId | wc -l | xargs` == 1 ]; then
	clear
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo "                                                                                       #################################################################"
        echo "                                                                                       #                       __ ATTENTION __                         #"
        echo "                                                                                       #                                                               #"
        echo "                                                                                       #             CLE USB D'AUTHENTIFICATION CONNECTEE              #"
        echo "                                                                                       #                    OUVERTURE DE LA SESSION                    #"
        echo "                                                                                       #                        EN COURS ...                           #"
        echo "                                                                                       #                                                               #"
        echo "                                                                                       #################################################################"
else
        clear
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo "                                                                                       #################################################################"
        echo "                                                                                       #                       __ ATTENTION __                         #"
        echo "                                                                                       #                                                               #"
        echo "                                                                                       #            BRANCHER LA CLE USB D'AUTHENTIFICATION             #"
        echo "                                                                                       #                POUR DEVEROUILLER CORRECTEMENT                 #"
        echo "                                                                                       #                        LE POSTE ...                           #"
        echo "                                                                                       #                                                               #"
        echo "                                                                                       #################################################################"
        echo ""
        echo ""
        echo ""
        echo ""
        echo "                                                                               La clé d'authentification n'est pas branchée. Verrouillage de la session en cours..."
fi
sleep 1
done;
EOF
chmod +x $scriptwait
echo "script généré"
else
echo "le script existe déjà"
fi

echo "-> Script opensession.sh pour informer le joueur du déverrouillage de session"
if [ ! -e $scriptopen ]; then
cat > $scriptopen <<EOF
#!/bin/bash
while true; do
        clear
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo ""
        echo "                                                                                       #################################################################"
        echo "                                                                                       #                       __ ATTENTION __                         #"
        echo "                                                                                       #                                                               #"
        echo "                                                                                       #             CLE USB D'AUTHENTIFICATION CONNECTEE              #"
        echo "                                                                                       #                    OUVERTURE DE LA SESSION                    #"
        echo "                                                                                       #                        EN COURS ...                           #"
        echo "                                                                                       #                                                               #"
        echo "                                                                                       #################################################################"
	sleep 10
done
EOF
chmod +x $scriptopen
echo "le script a été généré"
else
echo " le script existe déjà"
fi


echo ""
echo "#################################################################################"
echo ""
echo "Configuration de la clé USB d'authentification"
DeviceIdFile=/home/pi/Device.id

#Verifie la présence du fichier contenant le device a verifier
if [ ! -f $DeviceIdFile ]; then
    echo  -e "\n\n\n\nDébranchez votre périphérique de l'ordinateur, et appuyez sur [entrée]"
    read plop
    lsusb > /tmp/plop1
    echo "Rebranchez votre périphérique à l'ordinateur, et appuyez sur [entrée]"
    read plop
    lsusb > /tmp/plop2
    echo `diff /tmp/plop1 /tmp/plop2 | tail -n1 | cut -d' ' -f7` > $DeviceIdFile
fi

echo "L'empreinte de la clé a été enregistrée"

DeviceId=`cat $DeviceIdFile`
clear
echo "La machine se verrouillera automatiquement si"
echo "Le périphérique que vous avez configué ($DeviceId) n'est pas branché"
echo -n "Appuyer sur [Entrer] pour continuer"
read plop

i=0

while true; do
    clear
    echo "#################@ MENU PRINCIPAL @#################"
    echo
    echo "          Lancer le script ------------- 1"
    echo "          Changer de clé USB ----------- 2"
    echo "          Quitter ---------------------- Q"
    echo
    echo -n " Votre choix : "

    read choix

    case $choix in
    1)
        clear
        echo "                  /!\ ATTENTION /!\ " 
        echo "              Avant de lancer le script"
        echo "                débranchez la clé USB"
        echo "        La session se verrouillera toute seule"
        echo
        echo -n "Appuyez sur [Entrer] une fois que vous avez débranché la clé"
        read
        clear
        echo "Lancement du script"
        #Boucle tant que le script est actif pour vérifier la présence de votre périphérique
        lxterminal --geometry=238x64 -e ./wait.sh
        j=0
        while [ "$j" == "0" ]; do
            sleep 0.2
            # Si périphérique est branché
            if [ `lsusb | grep $DeviceId | wc -l | xargs` == "1" ]; then
                echo "ok"
                lxterminal --geometry=238x64 -e ./opensession.sh
                vncviewer -config /home/pi/pc-hacker.vnc
                j=1
                pkill wait
                pkill opensession
            else
                    echo "Verrouillage de la session"
                    xscreensaver-command -lock
            fi
        done;
    ;;
    2)
        echo "Changement de clé USB :"
        echo  -e "-> Débranchez votre périphérique de l'ordinateur, et appuyez sur [entrée]"
        read plop
        lsusb > /tmp/plop1
        echo " -> Rebranchez votre périphérique à l'ordinateur, et appuyez sur [entrée]"
        read plop
        lsusb > /tmp/plop2
        echo `diff /tmp/plop1 /tmp/plop2 | tail -n1 | cut -d' ' -f7` > $DeviceIdFile
        DeviceId=`cat $DeviceIdFile`
        echo
        echo "Votre nouvelle clé ($DeviceId) a été enregistrée"
        echo "Elle sera utilisée pour verrouiller la machine"
        echo "Appuyez sur [Entrer] pour revenir au menu Principal"
        read
    ;;
    [qQ] )
        break
    ;;
    esac
done;