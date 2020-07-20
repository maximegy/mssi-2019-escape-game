# NOTES 

## Description des scripts 
[launcher] - lance les autres scripts
[escape\_f\_util] - contient les fonctions commune et utilitaire
[settings.ini] - Options et parametres pour l'escape game
[m\_\*] - script qui gére les différents menu
[boot] - script qui simule un lancement du poste de la hackeuse

## Déroulé des scripts 
launch -> start\_poste -> m\_principal

## A FAIRE
### PRIORITAIRE
> Mise en place du timer en cours
> Pour le moment le programme principal ce ferme au lancement du timer
> Faire un fichier temporaire pour stocker la date de debut et de fin du timer -> permet de garder le timer même en cas de fermeture

- [x] Rajouter un menu pour rentrer un code qui permet de deverouiller les actions cachées
- [x] Faire un bashrc avec uniquement l'utilisation du script au lancement 
> Attention le lancement ce fait sur le launcher 
- [x] Mettre en place une interface avec un timer 
- [ ] Rajouter le sous menu maltego
- [x] Faire un cron avec un script type 'keep alive' qui relance le script de la hackeuse en cas de fermeture de la fenetre avec la croix 
> a tester
- [ ] Mettre en place un systeme de message pour recevoir des messages des MJ > utilisation des tty ?
- [x] Rajouter le sous menu connexion a distance
- [x] Rajouter le sous menu boite mail
- [x] Rajouter le sous menu journal
- [x] Rajouter des instructions en gras pour plus de lisabilité
- [x] Séparer le tout en plusieurs scripts

### SECONDAIRE
- [ ] Faire une interface admin avec une gestion possible des bugs et des valeurs en direct
- [ ] Rajouter le contenu dans les mails / journaux
- [ ] Faire une fonction d'ouverture d'image
- [ ] Mettre le code en anglais et les commentaires en FR
- [ ] Dans la validation des donnees afficher les retour alignées avec column
- [ ] Finir la partie DEBUG qui desactive les touches ctrl
- [x] Syncroniser tout les sleeps avec les valeurs en settings
- [x] Ameliorer le demarage du poste
- [x] Embellir le menu
- [x] Rajouter un fichier de settings avec par exemples les differents modes d'utiliation ou les temps de sleep
- [x] Faire un script qui export les commentaires en debuts de script pour les décrires
- [x] Rajouter tout les fichiers et constantes utilisés dans la validation des données


