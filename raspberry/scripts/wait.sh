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