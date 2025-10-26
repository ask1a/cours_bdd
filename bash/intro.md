# Linux & BASH
Connaitre les bases du langage de programmation Bash et le fonctionnement des systèmes Linux

## 0. Accéder à un terminal Bash selon votre système
Différentes méthodes pour accéder à un terminal Bash selon que vous utilisez Windows, macOS ou Linux.

---

### 0.1. Utilisateurs Windows
Option recommandée : **WSL (Windows Subsystem for Linux)**
WSL permet d'exécuter une distribution Linux directement dans Windows.

#### Installation de WSL (Windows 10 ou 11)

1. **Ouvrir PowerShell ou cmd en mode administrateur**
2. Exécuter la commande :
   ```bash
   wsl --install -d Ubuntu
   ```
3. Redémarrer l’ordinateur si demandé

---

### 0.2. Utilisateurs macOS
macOS est basé sur Unix, donc Bash est accessible nativement.

Accès au terminal
Ouvrir Terminal via Spotlight (Cmd + Espace, puis taper "Terminal")

Par défaut, le shell est zsh, mais Bash est disponible :
```bash
bash
```
Vous pouvez changer le shell par défaut vers Bash :
```bash
chsh -s /bin/bash
```

---


### 0.3. Utilisateurs Linux
Linux dispose nativement d’un terminal Bash.

Accès
Ouvrir le terminal via le raccourci clavier (Ctrl + Alt + T) ou via le menu

Bash est généralement le shell par défaut

---

### 0.4. Utiliser github codespaces
Conditions:
 - avoir un compte GitHub 
 - utiliser un dépôt compatible

Depuis un dépôt GitHub : 
 - Va sur n’importe quel dépôt (le tien ou un public).
 - Clique sur le bouton <> Code.
 - Sélectionne l’onglet Codespaces.
 - Clique sur Create codespace on main (ou sur une autre branche si tu préfères).

<img width="203" height="165" alt="image" src="https://github.com/user-attachments/assets/80105ae4-a205-47d8-9b97-ae7c461b2932" />

---

## 1. Architecture du système
Un système linux suis une architecture classique en arborescence avec dossiers, éventuels sous-dossiers et fichiers. Ainsi, si un dossier `dossier1` contient deux sous-dossiers `sousdossier1` et `sousdossier2`, on peut représenter la structure de la manière suivante:
```
dossier1

 - sousdossier1
 - sousdossier2
```
si maintenant on créé dans le `sousdossier1` deux fichiers `fichier1` et `fichier2` on va avoir la structure:
```
dossier1

 - sousdossier1
 - - fichier1
 - - fichier2
 - sousdossier2
```
L'architecture du système démarre à la racine désignée par le symbole `/`.  
Le chemin vers notre `fichier2` va donc être : `/dossier1/sousdossier1/fichier2`.  
A noter que dans un système linux, l'extension de fichier (ex: `.txt`, `.xls`, `.pdf`, etc...) n'est pas obligatoire. On trouvera par exemple des fichiers sans extensions ou sans nom avant l'extension par exemple : `Dockerfile`, `.env` ou encore `.gitignore`
