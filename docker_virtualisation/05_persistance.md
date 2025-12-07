## 5. Persistance des données
Par défaut, Docker ne conserve pas les données créées dans un container : elles disparaissent lorsque celui-ci est arrêté.

### Exemple sans persistance
Lançons un container basé sur une image légère (alpine:latest) :

```bash
docker container run --rm --name my_alpine -it alpine:latest
```
À l’intérieur du container, créons un fichier :

```bash
echo "hello world from Docker" > /home/test.txt
cat /home/test.txt
```
Après avoir quitté (exit) puis relancé un nouveau container Alpine, le fichier n’existe plus : les données ne sont pas persistantes.

### Exemple avec persistance
Pour conserver les données, on utilise les volumes.

Créez un volume :

```bash
docker volume create --name my_volume
docker volume ls
docker volume inspect my_volume
```

Montez ce volume dans un container Alpine :

```bash
docker container run -it --name my_alpine \
  --mount type=volume,src=my_volume,dst=/home/my_folder \
  --rm alpine:latest sh
```

À l’intérieur du container, créez un fichier :

```bash
echo "hello world from Docker" > /home/my_folder/test.txt
```

Vérifiez depuis la machine hôte :

```bash
sudo ls /var/lib/docker/volumes/my_volume/_data
sudo cat /var/lib/docker/volumes/my_volume/_data/test.txt
```

Le fichier est bien conservé dans le volume, même après arrêt du container.

### Partage entre containers
Un même volume peut être monté dans plusieurs containers :

```bash
docker container run -it --name my_alpine1 \
  --mount type=volume,src=my_volume,dst=/home/my_folder1 \
  --rm alpine:latest sh


docker container run -it --name my_alpine2 \
  --mount type=volume,src=my_volume,dst=/home/my_folder2 \
  --rm alpine:latest sh
```
Les fichiers créés dans /home/my_folder1 ou /home/my_folder2 sont visibles depuis les deux containers : le volume agit comme un espace de stockage partagé.

### Montage d’un dossier hôte
On peut aussi relier directement un dossier de la machine hôte à un container :

```bash
docker container run -it --name my_alpine \
  --volume $HOME:/home/my_folder \
  --rm alpine:latest sh
```
Le contenu du dossier $HOME est alors accessible dans /home/my_folder à l’intérieur du container. Cette méthode est pratique pour échanger des fichiers, mais elle réduit l’isolation et la sécurité.

## En résumé : 
sans volume, les données disparaissent à l’arrêt du container.  

Les volumes permettent de conserver et partager des fichiers entre containers, tandis que le montage de dossiers hôte facilite les échanges mais avec moins de sécurité.
