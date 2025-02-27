# pzs-ng-vnstat

**pzs-ng-vnstat** est un plugin pour **pzs-ng** permettant d'afficher les statistiques de bande passante de **vnstat** dans les salons IRC. Il fournit une interface simple pour consulter les informations sur la bande passante pour des périodes spécifiques (par défaut, sur la journée).

## Table des matières

1. [Description](#description)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Utilisation](#utilisation)
5. [Exemples](#exemples)
6. [Contribuer](#contribuer)
7. [Dépannage](#dépannage)
8. [Licence](#licence)

## Description

Le plugin **pzs-ng-vnstat** permet aux utilisateurs IRC de consulter facilement les statistiques de bande passante via des commandes simples. Ce plugin utilise **vnstat**, un outil de suivi de la bande passante réseau pour Linux, pour afficher les statistiques en temps réel ou historiques pour différentes périodes telles que **jour**, **mois**, ou **heure**.

## Installation

### Prérequis

Avant de commencer l'installation, assurez-vous que vous avez installé **vnstat** sur votre système. Si ce n'est pas le cas, vous pouvez l'installer via votre gestionnaire de paquets :

```bash
# Sur Debian/Ubuntu
sudo apt install vnstat

# Sur Fedora
sudo dnf install vnstat

# Sur Arch Linux
sudo pacman -S vnstat
```

### Étapes d'installation

1. Clonez ce dépôt dans le répertoire `plugins` de votre bot **pzs-ng**.

   ```bash
   cd /path/to/your/pzs-ng/plugins
   git clone https://github.com/ZarTek-Creole/pzs-ng-vnstat.git
   ```

2. Ouvrez le fichier `eggdrop.conf` et ajoutez la ligne suivante pour charger le plugin :

   ```tcl
   source /path/to/your/pzs-ng/plugins/pzs-ng-vnstat/vtraffic.tcl
   ```

3. Redémarrez ou rehash votre bot IRC :

   ```bash
   rehash
   ```

### Dépendances

- **vnstat** : Assurez-vous que **vnstat** est installé et configuré correctement sur votre système.
- **pzs-ng** : Ce plugin nécessite **pzs-ng** pour fonctionner. Assurez-vous que **pzs-ng** est bien installé sur votre bot.

## Configuration

Aucune configuration spécifique n'est nécessaire pour faire fonctionner ce plugin. Cependant, vous pouvez personnaliser les périodes de suivi (par exemple, `day`, `hour`, `month`) en modifiant la commande **vnstat** dans le fichier **vtraffic.tcl**.

### Exemple de personnalisation

Si vous souhaitez suivre une autre interface réseau, vous pouvez ajuster la commande **vnstat** dans le fichier **vtraffic.tcl** :

```tcl
set command "vnstat -$periode -i eth0"  ; # Remplacez "eth0" par l'interface réseau souhaitée.
```

## Utilisation

Une fois le plugin installé et configuré, vous pouvez utiliser la commande `!vtraffic` dans un salon IRC pour obtenir un résumé des statistiques de bande passante.

### Commande

```bash
!vtraffic <periode>
```

- **periode** : Période pour laquelle vous souhaitez obtenir des statistiques. Les valeurs valides sont : `day`, `hour`, `month`.
  - Par défaut, **jour** est utilisé si aucune période n'est spécifiée.

### Exemple de commande

- **Commandes IRC** :
  - `!vtraffic day` : Affiche les statistiques de bande passante pour la journée en cours.
  - `!vtraffic month` : Affiche les statistiques de bande passante pour le mois en cours.
  - `!vtraffic hour` : Affiche les statistiques de bande passante pour l'heure actuelle.

### Format de sortie

Les résultats seront renvoyés sous un format lisible sur IRC, comme suit :

```
[Traffic day] - 500MB / 1GB received / 200MB sent
```

## Exemples

1. **Consulter les statistiques pour la journée actuelle** :
   - Tapez `!vtraffic day` dans le salon IRC, et le bot renverra les statistiques du jour.

2. **Consulter les statistiques pour le mois actuel** :
   - Tapez `!vtraffic month` pour obtenir les informations mensuelles.

3. **Consulter les statistiques pour l'heure actuelle** :
   - Tapez `!vtraffic hour` pour obtenir les statistiques de l'heure en cours.

## Contribuer

Nous accueillons toutes les contributions à ce projet. Si vous souhaitez contribuer, suivez ces étapes :

1. Fork ce dépôt.
2. Créez une branche pour votre fonctionnalité ou correction de bug (`git checkout -b feature-xyz`).
3. Faites vos modifications.
4. Faites un commit avec un message clair et concis (`git commit -am 'Ajout de [fonctionnalité]'`).
5. Poussez sur votre fork (`git push origin feature-xyz`).
6. Ouvrez une pull request pour fusionner vos modifications dans la branche principale.

### Règles de contribution

- Assurez-vous que votre code est bien documenté.
- Respectez le style de code utilisé dans le projet.
- Testez votre code avant de soumettre une pull request.

## Dépannage

Voici quelques problèmes courants et leurs solutions :

### 1. **Le plugin ne renvoie pas de résultats pour `!vtraffic`**

- **Cause** : Il se peut que **vnstat** ne soit pas configuré correctement ou qu'il n'y ait pas de données disponibles pour la période demandée.
- **Solution** : Assurez-vous que **vnstat** fonctionne correctement en exécutant la commande suivante dans votre terminal :
  ```bash
  vnstat
  ```
  Si **vnstat** n'affiche pas de données, vérifiez que l'interface réseau est correctement configurée et qu'il collecte des statistiques.

### 2. **Commande `!vtraffic` inconnue**

- **Cause** : Le plugin n'a peut-être pas été chargé correctement.
- **Solution** : Vérifiez que la ligne `source /path/to/your/pzs-ng/plugins/pzs-ng-vnstat/vtraffic.tcl` a bien été ajoutée à votre fichier `eggdrop.conf`. N'oubliez pas de redémarrer ou de rehash votre bot.

### 3. **Problème avec les permissions d'exécution de `vnstat`**

- **Cause** : Si `vnstat` n'a pas les permissions nécessaires pour accéder aux données réseau.
- **Solution** : Vérifiez que **vnstat** peut être exécuté sans problème par l'utilisateur sous lequel le bot s'exécute. Vous pouvez tester cela en exécutant `vnstat` en ligne de commande.

## Licence

Ce projet est sous la licence [MIT](https://opensource.org/licenses/MIT). Vous êtes libre d'utiliser, modifier et distribuer ce code, à condition de respecter les termes de la licence MIT.
