#!/bin/bash
# Prépare l'exercice « Premier jour dans l'équipe ».
#
# Le projet est créé EN DEHORS du dépôt du cours (par défaut dans ~/projet_recettes),
# car un dépôt Git placé à l'intérieur d'un autre dépôt Git crée des confusions.
# On peut changer les emplacements avec les variables PROJET_GIT et DISTANT_GIT.

ICI="$(cd "$(dirname "$0")" && pwd)"
COULISSES="$ICI/.coulisses"
PROJET="${PROJET_GIT:-$HOME/projet_recettes}"
DISTANT="${DISTANT_GIT:-$HOME/depot_distant.git}"

if ! command -v git >/dev/null 2>&1; then
    echo "Git n'est pas installé : impossible de faire l'exercice."
    exit 1
fi

if [ -e "$PROJET" ]; then
    echo "L'exercice est déjà commencé : $PROJET"
    echo
    echo "Pour continuer :"
    echo "    cd $PROJET"
    echo "    cat consignes"
    echo
    echo "Pour tout recommencer depuis le début :"
    echo "    bash $ICI/reinitialiser.sh"
    exit 0
fi

PARENT="$(dirname "$PROJET")"
mkdir -p "$PARENT"
if git -C "$PARENT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Le dossier $PARENT est déjà dans un dépôt Git."
    echo "Le projet doit être créé ailleurs, par exemple :"
    echo "    PROJET_GIT=/tmp/projet_recettes bash $0"
    exit 1
fi

mkdir -p "$PROJET"
rm -rf "$DISTANT"

printf 'ETAPE=1\nPRINCIPALE=\nDISTANT=%s\n' "$DISTANT" > "$PROJET/.etat"
cp "$COULISSES/consignes/01.txt" "$PROJET/consignes"
cat > "$PROJET/verifier.sh" <<EOF
#!/bin/bash
# Vérifie l'étape en cours. Usage : bash verifier.sh
bash "$COULISSES/moteur.sh" "\$(cd "\$(dirname "\$0")" && pwd)"
EOF

echo "Le projet est prêt."
echo
echo "Pour commencer :"
echo "    cd $PROJET"
echo "    cat consignes"
