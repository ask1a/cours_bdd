# Premier jour dans l'équipe : exercice Git

Un exercice guidé qui se fait entièrement dans le terminal, pour mettre en pratique le cours Git.
Tu viens d'arriver dans une petite équipe qui rédige un carnet de recettes partagé. Chaque étape est une tâche à réaliser avec des commandes Git, et un fichier `consignes` t'explique ce que tu dois faire.

| Étape | Notions travaillées | Chapitre du cours |
|-------|---------------------|-------------------|
| 1. Créer le dépôt | `git init`, `git status`, le dossier `.git` | [03](../03_fonctionnement.md), [04](../04_creer_depot_git.md) |
| 2. Se présenter à Git | `git config` local et global | [02](../02_parametrage_et_initialisation.md) |
| 3. Premier commit | `git add`, `git commit`, `git log` | [03](../03_fonctionnement.md), [04](../04_creer_depot_git.md) |
| 4. L'index | `git reset HEAD` | [05](../05_modifier_des_fichiers.md) |
| 5. Ignorer des fichiers | `.gitignore` | [05](../05_modifier_des_fichiers.md) |
| 6. Supprimer et renommer | `git rm`, `git mv` | [05](../05_modifier_des_fichiers.md) |
| 7. Un secret dans le dépôt | `git rm --cached`, secrets dans l'historique | [05](../05_modifier_des_fichiers.md) |
| 8. Travailler sur une branche | `git branch`, `git checkout`, `HEAD` | [06](../06_branches.md) |
| 9. Fusionner une branche | `git merge` en avance rapide, `git branch -d` | [07](../07_fusion.md) |
| 10. Résoudre un conflit | conflit de fusion et sa résolution | [07](../07_fusion.md) |
| 11. Pousser vers un dépôt distant | `git remote`, `git push -u` | [08](../08_repo_distant.md) |
| 12. Récupérer le travail des autres | `git fetch`, `git pull` | [08](../08_repo_distant.md) |
| Bonus | `git rebase` | [07](../07_fusion.md) |

---

## Prérequis

Un terminal Bash avec Git : GitHub Codespaces convient parfaitement, tout comme Linux, WSL, macOS ou Git Bash.

## Commencer l'exercice

Depuis la racine du dépôt du cours :

```bash
bash git_github/exercice/commencer.sh
cd ~/projet_recettes
cat consignes
```

Ensuite, laisse-toi guider par les consignes.

> **Pourquoi `~/projet_recettes` et pas un dossier du cours ?**
> Tu vas créer un *vrai* dépôt Git avec `git init`. S'il se trouvait à l'intérieur du dépôt du cours, Git aurait un dépôt dans un dépôt, et ce serait vite la pagaille. Le projet est donc créé dans ton dossier personnel.
> Le dépôt distant utilisé à la fin de l'exercice est créé dans `~/depot_distant.git`.

## Règles

- On lit les consignes de l'étape en cours avec `cat consignes`.
- Quand tu penses avoir terminé l'étape, lance `bash verifier.sh`. Si l'étape est réussie, de nouvelles consignes apparaissent. Sinon, un message t'indique ce qui ne va pas.
- Des collègues fictifs (Camille, Sam, Alex, Noa) font eux aussi des commits dans le dépôt. Regarde `git log` pour savoir qui a fait quoi !
- Ne modifie pas les fichiers `consignes`, `verifier.sh` et `.etat` : ils font partie de l'exercice. Ils sont cachés à Git, donc ils n'apparaissent pas dans `git status`.
- Le dossier caché `.coulisses/` contient le moteur de l'exercice : **n'y va pas**, ce serait de la triche !

## Recommencer l'exercice

Depuis la racine du dépôt du cours :

```bash
bash git_github/exercice/reinitialiser.sh
```

Cette commande supprime `~/projet_recettes` et `~/depot_distant.git`, puis recrée un exercice neuf.
