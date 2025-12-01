# Travailler avec des dépôts distants
Jusqu’ici, nous avons utilisé Git en local. Mais en pratique, les projets sont souvent collaboratifs : plusieurs personnes travaillent ensemble sur le même code. Pour cela, on utilise des dépôts distants, hébergés sur des serveurs accessibles via Internet ou un réseau d’entreprise.

La gestion des dépôts distants est plus complexe que celle des dépôts locaux, car il faut :

 - gérer les droits d’accès des utilisateurs,
 - décider quelles modifications doivent être intégrées,
 - coordonner les contributions.

Principe : on clone le dépôt distant en local, on fait ses modifications, puis on les pousse vers le serveur. Les changements peuvent ensuite être acceptés ou rejetés.

## Cloner, afficher et renommer un dépôt distant
Cloner un dépôt :

```bash
git clone url-du-depot
```

Lister les dépôts distants associés :

```bash
git remote
git remote -v   # affiche les URLs
```
Par défaut, le dépôt cloné est nommé origin.


## Récupérer des données depuis un dépôt distant
Récupérer les nouvelles données sans les fusionner :

```bash
git fetch
```
→ Les données sont téléchargées mais restent séparées.

Récupérer et fusionner directement :

```bash
git pull
```
→ Les modifications de la branche distante sont intégrées dans la branche locale.

## Pousser des modifications vers un dépôt distant
Commande :

```bash
git push nom-distant nom-de-branche
```
Exemple :

```bash
git push origin master
```
Conditions :
 - avoir les droits d’écriture sur le serveur,
 - éviter les conflits si quelqu’un d’autre a poussé des modifications entre-temps.

## Obtenir des informations sur un dépôt distant
Commande :

```bash
git remote show nom-distant
```
Donne :

 - les URLs du dépôt,
 - les branches suivies,
 - celles fusionnées automatiquement avec git pull,
 - celles poussées avec git push.


# En résumé :

 - `git clone` → copier un dépôt distant.
 - `git fetch` → récupérer sans fusionner.
 - `git pull` → récupérer et fusionner.
 - `git push` → envoyer ses modifications.
 - `git remote` → gérer les dépôts distants (ajout, renommage, suppression).


### Sous-chapitre : L'Authentification via Personal Access Token (PAT)
Depuis 2021, GitHub a supprimé l'authentification par mot de passe pour les opérations en ligne de commande (HTTPS). Cela signifie que si vous essayez de faire un git push en utilisant votre mot de passe de compte habituel, cela échouera.

À la place, vous devez utiliser un Personal Access Token (PAT). C'est une chaîne de caractères générée par GitHub qui agit comme un mot de passe temporaire et révocable, spécifique à votre machine ou à vos scripts.

#### Comment générer un Token (PAT) sur GitHub  
Voici la procédure pas à pas pour créer votre "clé" d'accès :
 - Connectez-vous à votre compte GitHub.
 - Cliquez sur votre avatar en haut à droite -> Settings.
 - Dans le menu de gauche, tout en bas, cliquez sur Developer settings.
 - Sélectionnez Personal access tokens -> Tokens (classic).
 - Cliquez sur le bouton Generate new token -> Generate new token (classic).
Note : Donnez un nom (ex: "Mon PC Portable") et choisissez une date d'expiration (recommandé : 30 à 90 jours).
Select scopes (Les permissions) : Pour un usage standard, cochez simplement la case repo (cela inclut le contrôle complet des dépôts privés et publics).Cliquez sur Generate token en bas de page.
#### Important : Copiez votre token immédiatement. Une fois que vous quittez cette page, vous ne pourrez plus jamais voir ce token. Si vous le perdez, vous devrez en générer un nouveau.


### Utiliser le Token pour Cloner (git clone)   
Il existe deux méthodes pour utiliser votre token lors d'un clonage.

#### Méthode A : L'invite de commande (Recommandée)  
Lorsque vous lancez la commande de clonage en HTTPS, Git va vous demander vos identifiants.

Tapez votre commande :

```Bash
git clone https://github.com/votre-utilisateur/votre-repo.git
```
Git demande Username : Entrez votre nom d'utilisateur GitHub.

Git demande Password : Collez ici votre Token (PAT) et non votre mot de passe habituel.

Note : Sur la plupart des terminaux (Linux/Mac/Windows), rien ne s'affiche quand vous collez le mot de passe (pas d'étoiles ***). C'est normal, validez simplement avec Entrée.

#### Méthode B : L'insertion directe dans l'URL (Pour les scripts)  
Vous pouvez inclure le token directement dans l'URL. C'est utile pour l'automatisation, mais risqué car le token apparaît dans votre historique de commandes.

```Bash

git clone https://VOTRE_TOKEN@github.com/votre-utilisateur/votre-repo.git
```
#### Utiliser le Token pour Push et Pull  
Si vous avez déjà cloné un dépôt et que Git vous demande un mot de passe lors d'un git push ou git pull, le principe est le même que pour le clonage :

Lancez git push.

À l'invite Password, collez votre Token.

Éviter de taper le Token à chaque fois  
Taper ce long token à chaque interaction est fastidieux. Vous pouvez demander à Git de le mémoriser dans le gestionnaire d'identifiants de votre système (Credential Helper).

Lancez cette commande une seule fois dans votre terminal :

```Bash
git config --global credential.helper store
```
La prochaine fois que vous ferez un git push et entrerez votre token, Git le sauvegardera localement. Vous n'aurez plus besoin de le saisir tant qu'il n'aura pas expiré.
