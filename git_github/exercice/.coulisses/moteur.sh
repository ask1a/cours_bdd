#!/bin/bash
# Moteur de l'exercice « Premier jour dans l'équipe ».
# Appelé par le verifier.sh du projet : bash moteur.sh <dossier_du_projet>
# Si tu lis ceci pour trouver les réponses, retourne plutôt aux consignes !

COULISSES="$(cd "$(dirname "$0")" && pwd)"
PROJET="$1"
ETAT="$PROJET/.etat"

if [ -z "$PROJET" ] || [ ! -f "$ETAT" ]; then
    echo "Impossible de trouver l'état de l'exercice."
    echo "Lance d'abord : bash commencer.sh (dans git_github/exercice/)"
    exit 1
fi

# shellcheck source=/dev/null
source "$ETAT"   # ETAPE, PRINCIPALE, DISTANT

# ---------------------------------------------------------------- utilitaires
g() { git -C "$PROJET" "$@"; }

echec() {
    echo
    printf '  %s\n' "$@"
    echo
    exit 1
}

sauver() {
    printf 'ETAPE=%s\nPRINCIPALE=%s\nDISTANT=%s\n' \
        "$ETAPE" "$PRINCIPALE" "$DISTANT" > "$ETAT"
}

installer_consignes() {
    sed -e "s#__BRANCHE__#${PRINCIPALE:-master}#g" \
        -e "s#__DISTANT__#${DISTANT}#g" \
        "$COULISSES/consignes/$(printf '%02d' "$1").txt" > "$PROJET/consignes"
}

passer_a_l_etape() {
    ETAPE="$1"
    sauver
    installer_consignes "$ETAPE"
    echo
    echo "  >>> Étape validée ! Nouvelles consignes :  cat consignes"
    echo
}

existe_dans() { g cat-file -e "$1:$2" 2>/dev/null; }      # existe_dans <commit> <fichier>
est_indexe()  { g ls-files --error-unmatch -- "$1" >/dev/null 2>&1; }
est_ignore()  { g check-ignore -q -- "$1"; }
branche_existe() { g show-ref --verify -q "refs/heads/$1"; }
branche_courante() { g symbolic-ref --short -q HEAD; }
est_propre() { [ -z "$(g status --porcelain)" ]; }
a_un_commit() { g rev-parse -q --verify HEAD >/dev/null 2>&1; }

exiger_propre() {
    if ! est_propre; then
        echec "Il reste des modifications non validées :" \
              "" \
              "$(g status --short)" \
              "" \
              "Regarde 'git status' et termine ton travail (git add / git commit)."
    fi
}

# Commit fait par un collègue fictif (pas par l'élève)
commit_collegue() {
    local nom="$1" mail="$2"; shift 2
    g -c user.name="$nom" -c user.email="$mail" -c commit.gpgsign=false \
      commit -q -m "$*"
}

SECRET='CLE_API=exemple-0000-ne-pas-partager'

# -------------------------------------------------------------------- étapes
etape_1() {
    [ -d "$PROJET/.git" ] || echec \
        "Ce dossier n'est toujours pas un dépôt Git (pas de dossier .git)." \
        "Tape : git init"

    # Les fichiers de l'exercice sont cachés à Git (comme un .gitignore, mais local)
    printf '%s\n' "consignes" "verifier.sh" ".etat" >> "$PROJET/.git/info/exclude"
    # Dépôt d'entraînement : pas de signature GPG (Codespaces peut l'activer)
    g config --local commit.gpgsign false

    echo "Le dépôt est créé."
    echo "Les fichiers de l'exercice (consignes, verifier.sh) sont maintenant"
    echo "cachés à Git : tape 'git status', ils ont disparu de la liste."
    passer_a_l_etape 2
}

etape_2() {
    local nom mail
    nom="$(g config --local user.name)"
    mail="$(g config --local user.email)"
    if [ -z "$nom" ] || [ -z "$mail" ]; then
        if [ -n "$(git config --global user.name)" ]; then
            echec "Aucun nom n'est configuré pour CE dépôt." \
                  "As-tu utilisé --global ? Ici on veut une configuration locale :" \
                  "    git config user.name \"Prénom Nom\"" \
                  "    git config user.email \"prenom.nom@exemple.fr\""
        fi
        echec "Ton nom ou ton e-mail n'est pas encore configuré." \
              "    git config user.name \"Prénom Nom\"" \
              "    git config user.email \"prenom.nom@exemple.fr\""
    fi
    echo "Bienvenue dans l'équipe, $nom ! Tes commits porteront ce nom."
    passer_a_l_etape 3
}

etape_3() {
    a_un_commit || {
        if est_indexe README.md; then
            echec "README.md est indexé, mais rien n'est encore validé." \
                  "Il manque : git commit -m \"Ajout du README\""
        elif [ -f "$PROJET/README.md" ]; then
            echec "README.md existe mais Git ne le suit pas encore." \
                  "Indexe-le (git add README.md) puis valide-le (git commit -m \"...\")."
        fi
        echec "Aucun commit dans le dépôt. Commence par créer README.md."
    }
    existe_dans HEAD README.md || echec \
        "Ton dernier commit ne contient pas README.md." \
        "git add README.md puis git commit -m \"...\""
    [ -n "$(g show HEAD:README.md | tr -d '[:space:]')" ] || echec \
        "Ton README.md est vide ! Écris au moins une ligne dedans," \
        "puis git add README.md et git commit -m \"...\""

    PRINCIPALE="$(branche_courante)"
    PRINCIPALE="${PRINCIPALE:-master}"

    echo "Premier commit enregistré."
    echo "Ta branche principale s'appelle : $PRINCIPALE"
    echo
    echo "Camille, la responsable du projet, ajoute quelques fichiers..."
    printf 'Crêpes\n- 250 g de farine\n- 4 œufs\n- 50 cl de lait\n' > "$PROJET/crepes.txt"
    printf 'Gâteau au chocolat\n- 200 g de chocolat\n- 3 œufs\n' > "$PROJET/gateau.txt"
    printf 'Idées en vrac, pas encore relues... à ne pas publier.\n' > "$PROJET/brouillon.txt"
    g add crepes.txt gateau.txt brouillon.txt
    passer_a_l_etape 4
}

etape_4() {
    existe_dans HEAD brouillon.txt && echec \
        "brouillon.txt a été validé : il est dans ton dernier commit." \
        "Pas de panique, retire-le du suivi puis valide :" \
        "    git rm --cached brouillon.txt" \
        "    git commit -m \"Retrait du brouillon\"" \
        "(git rm --cached est expliqué en détail un peu plus loin.)"
    est_indexe brouillon.txt && echec \
        "brouillon.txt est toujours dans l'index (prêt à être validé)." \
        "Retire-le de l'index :  git reset HEAD brouillon.txt"
    { existe_dans HEAD crepes.txt && existe_dans HEAD gateau.txt; } || echec \
        "crepes.txt et gateau.txt ne sont pas encore validés." \
        "Vérifie avec git status, puis : git commit -m \"Ajout des premières recettes\"" \
        "(S'ils ne sont plus indexés : git add crepes.txt gateau.txt)"

    echo "Les recettes sont validées, et le brouillon est resté en dehors."
    echo
    echo "En lançant l'outil d'export du carnet, des fichiers de log sont apparus..."
    echo "Export terminé"            > "$PROJET/export.log"
    echo "Mode debug activé"         > "$PROJET/debug.log"
    echo "Aucune erreur"             > "$PROJET/erreurs.log"
    passer_a_l_etape 5
}

etape_5() {
    local f
    for f in export.log debug.log erreurs.log brouillon.txt; do
        existe_dans HEAD "$f" && echec \
            "$f a été validé dans le dépôt ! Il ne doit pas être versionné." \
            "Retire-le du suivi :  git rm --cached $f" \
            "puis git commit -m \"...\""
    done
    existe_dans HEAD .gitignore || {
        [ -f "$PROJET/.gitignore" ] && echec \
            "Ton .gitignore existe, mais il n'est pas encore validé." \
            "    git add .gitignore" \
            "    git commit -m \"Ajout du .gitignore\""
        echec "Il n'y a pas de fichier .gitignore." \
              "Relis les consignes : cat consignes"
    }
    for f in export.log debug.log erreurs.log brouillon.txt; do
        est_ignore "$f" || echec \
            "Git voit encore $f : ton .gitignore ne l'ignore pas." \
            "Regarde son contenu : cat .gitignore"
    done
    exiger_propre

    echo "Les logs et le brouillon sont toujours sur le disque, mais Git ne les voit plus."
    echo "Et le .gitignore est validé : toute l'équipe en profitera."
    passer_a_l_etape 6
}

etape_6() {
    existe_dans HEAD gateau.txt && echec \
        "gateau.txt est toujours dans ton dernier commit." \
        "    git rm gateau.txt" \
        "(Si tu as utilisé rm tout court, 'git rm gateau.txt' indexe la suppression.)" \
        "Puis git commit -m \"...\""
    existe_dans HEAD crepes_sucrees.txt || echec \
        "Le dernier commit ne contient pas crepes_sucrees.txt." \
        "    git mv crepes.txt crepes_sucrees.txt" \
        "puis git commit -m \"...\""
    existe_dans HEAD crepes.txt && echec \
        "L'ancien crepes.txt est toujours dans le commit." \
        "Utilise git mv (et pas une copie) pour renommer."
    exiger_propre

    echo "Le carnet est bien rangé."
    echo
    echo "Pendant ce temps, Sam (un collègue) a fait un commit un peu trop rapide..."
    printf '# Configuration de l outil d export\n%s\n' "$SECRET" > "$PROJET/config_secrete.txt"
    g add -f config_secrete.txt
    commit_collegue "Sam" "sam@exemple.fr" "Ajout de ma configuration"
    passer_a_l_etape 7
}

etape_7() {
    if [ ! -f "$PROJET/config_secrete.txt" ]; then
        printf '# Configuration de l outil d export\n%s\n' "$SECRET" > "$PROJET/config_secrete.txt"
        echec "Tu as supprimé config_secrete.txt de ton disque !" \
              "L'option --cached sert justement à GARDER le fichier en local." \
              "Le fichier a été recréé pour toi. Relance : bash verifier.sh"
    fi
    existe_dans HEAD config_secrete.txt && echec \
        "config_secrete.txt est toujours suivi dans ton dernier commit." \
        "    git rm --cached config_secrete.txt" \
        "puis ajoute-le au .gitignore et valide."
    est_ignore config_secrete.txt || echec \
        "Le fichier n'est plus suivi, mais il n'est pas ignoré :" \
        "il pourrait être réindexé par erreur avec un 'git add .'" \
        "    echo \"config_secrete.txt\" >> .gitignore"
    exiger_propre

    echo "La configuration de Sam reste sur le disque, mais elle ne sera plus versionnée."
    passer_a_l_etape 8
}

etape_8() {
    branche_existe nouvelle-recette || echec \
        "Il n'y a pas de branche 'nouvelle-recette'." \
        "    git branch nouvelle-recette" \
        "Liste les branches avec : git branch"
    existe_dans nouvelle-recette soupe.txt || echec \
        "La branche nouvelle-recette ne contient pas encore soupe.txt." \
        "Place-toi dessus (git checkout nouvelle-recette), crée soupe.txt," \
        "puis git add soupe.txt et git commit -m \"Ajout de la soupe\"."
    existe_dans "$PRINCIPALE" soupe.txt && echec \
        "soupe.txt est aussi dans la branche $PRINCIPALE !" \
        "Le commit a été fait sur la mauvaise branche (vérifie avec git log --oneline --all)." \
        "Pour l'annuler sur $PRINCIPALE :" \
        "    git checkout $PRINCIPALE" \
        "    git reset --hard HEAD~1" \
        "Puis recommence le commit sur la branche nouvelle-recette."

    echo "Tu as travaillé sur une branche sans toucher à la branche principale."
    echo "Les deux branches ont maintenant des historiques différents."
    passer_a_l_etape 9
}

etape_9() {
    [ "$(branche_courante)" = "$PRINCIPALE" ] || echec \
        "Tu dois être sur la branche $PRINCIPALE pour y intégrer la recette." \
        "    git checkout $PRINCIPALE"
    existe_dans "$PRINCIPALE" soupe.txt || echec \
        "soupe.txt n'est pas encore dans $PRINCIPALE." \
        "    git merge nouvelle-recette"
    branche_existe nouvelle-recette && echec \
        "La branche nouvelle-recette a été fusionnée : elle ne sert plus." \
        "    git branch -d nouvelle-recette"
    exiger_propre

    echo "La recette est intégrée (fusion en avance rapide, fast-forward)."
    echo
    echo "Pendant ce temps, Camille et Alex ont travaillé en parallèle sur la pizza..."

    # Construction d'un conflit : pizza.txt modifié différemment sur 2 branches
    printf 'Pizza\nCuisson : à définir.\n' > "$PROJET/pizza.txt"
    g add pizza.txt
    commit_collegue "Camille" "camille@exemple.fr" "Ajout de la pizza"
    g branch alex
    g checkout -q alex
    printf 'Pizza\nCuisson : 15 minutes à 220 °C.\n' > "$PROJET/pizza.txt"
    g add pizza.txt
    commit_collegue "Alex" "alex@exemple.fr" "Temps de cuisson de la pizza"
    g checkout -q "$PRINCIPALE"
    printf 'Pizza\nCuisson : 10 minutes à 250 °C.\n' > "$PROJET/pizza.txt"
    g add pizza.txt
    commit_collegue "Camille" "camille@exemple.fr" "Cuisson de la pizza"
    passer_a_l_etape 10
}

etape_10() {
    local marqueurs='^(<<<<<<<|=======|>>>>>>>)'
    if [ -f "$PROJET/.git/MERGE_HEAD" ]; then
        if grep -Eq "$marqueurs" "$PROJET/pizza.txt" 2>/dev/null; then
            echec "La fusion est en cours, mais pizza.txt contient encore" \
                  "des marqueurs de conflit (<<<<<<<, =======, >>>>>>>)." \
                  "Édite le fichier, garde le texte final et supprime les marqueurs."
        fi
        echec "Le conflit semble résolu, il reste à le valider :" \
              "    git add pizza.txt" \
              "    git commit -m \"Fusion de la branche alex\""
    fi
    branche_existe alex || echec \
        "La branche alex a disparu ! Il fallait la fusionner, pas la supprimer." \
        "Pour recommencer l'exercice : bash reinitialiser.sh (dans git_github/exercice/)"
    g merge-base --is-ancestor alex HEAD || echec \
        "Le travail d'Alex n'est pas encore fusionné." \
        "    git checkout $PRINCIPALE" \
        "    git merge alex"
    [ "$(branche_courante)" = "$PRINCIPALE" ] || echec \
        "Reviens sur ta branche principale : git checkout $PRINCIPALE"
    g show HEAD:pizza.txt | grep -Eq "$marqueurs" && echec \
        "Oups : tu as validé pizza.txt avec les marqueurs de conflit dedans !" \
        "Édite pizza.txt pour les retirer, puis git add pizza.txt et git commit."
    exiger_propre

    echo "Conflit résolu : l'équipe est d'accord sur la cuisson de la pizza."
    echo
    echo "Il est temps de partager le carnet sur le serveur de l'équipe..."
    rm -rf "$DISTANT"
    git init -q --bare "$DISTANT"
    git -C "$DISTANT" symbolic-ref HEAD "refs/heads/$PRINCIPALE"
    passer_a_l_etape 11
}

etape_11() {
    local url distant local_sha
    url="$(g remote get-url origin 2>/dev/null)" || echec \
        "Ton dépôt ne connaît aucun dépôt distant nommé origin." \
        "    git remote add origin $DISTANT"
    if [ "$(cd "$url" 2>/dev/null && pwd -P)" != "$(cd "$DISTANT" && pwd -P)" ]; then
        echec "origin pointe vers « $url »," \
              "mais le dépôt distant se trouve ici : $DISTANT" \
              "Corrige l'adresse :" \
              "    git remote set-url origin $DISTANT"
    fi
    distant="$(git -C "$DISTANT" rev-parse -q --verify "refs/heads/$PRINCIPALE")" || echec \
        "Le dépôt distant est encore vide : tu n'as rien poussé." \
        "    git push -u origin $PRINCIPALE"
    local_sha="$(g rev-parse "$PRINCIPALE")"
    [ "$distant" = "$local_sha" ] || echec \
        "Le dépôt distant n'a pas la même version que toi." \
        "Valide ton travail puis : git push origin $PRINCIPALE"

    echo "Ton travail est maintenant sur le dépôt distant."
    echo
    echo "Noa, une autre collègue, a cloné le dépôt et vient de pousser une recette..."
    # Une autre contributrice clone, ajoute un fichier, et pousse
    local tmp
    tmp="$(mktemp -d)"
    git clone -q "$DISTANT" "$tmp/noa"
    printf 'Tarte aux pommes\n- 1 pâte brisée\n- 4 pommes\n- 50 g de sucre\n' \
        > "$tmp/noa/tarte.txt"
    git -C "$tmp/noa" add tarte.txt
    git -C "$tmp/noa" -c user.name="Noa" -c user.email="noa@exemple.fr" \
        -c commit.gpgsign=false commit -q -m "Ajout de la tarte aux pommes"
    git -C "$tmp/noa" push -q origin "$PRINCIPALE"
    rm -rf "$tmp"
    passer_a_l_etape 12
}

etape_12() {
    existe_dans "$PRINCIPALE" tarte.txt || {
        existe_dans "origin/$PRINCIPALE" tarte.txt && echec \
            "Tu as récupéré le travail de Noa (fetch), mais il n'est pas fusionné" \
            "dans ta branche. Termine avec :" \
            "    git pull      (ou : git merge origin/$PRINCIPALE)"
        echec "Tu n'as pas encore récupéré le travail de Noa." \
              "    git fetch   puis   git pull"
    }

    ETAPE=13
    sauver
    installer_consignes 13
    echo
    cat "$PROJET/consignes"
}

# ------------------------------------------------------------------ aiguillage
case "$ETAPE" in
    1|2|3|4|5|6|7|8|9|10|11|12) "etape_$ETAPE" ;;
    13) echo "Tu as déjà terminé l'exercice ! (cat consignes)" ;;
    *)  echo "État de l'exercice inconnu. Recommence avec : bash reinitialiser.sh"; exit 1 ;;
esac
