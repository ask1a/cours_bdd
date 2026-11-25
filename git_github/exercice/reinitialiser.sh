#!/bin/bash
# Supprime le projet et le dépôt distant de l'exercice, puis recrée un exercice neuf.

ICI="$(cd "$(dirname "$0")" && pwd)"
PROJET="${PROJET_GIT:-$HOME/projet_recettes}"
DISTANT="${DISTANT_GIT:-$HOME/depot_distant.git}"

# Sécurité : on ne supprime que des dossiers qui ressemblent bien à l'exercice
if [ -e "$PROJET" ] && [ ! -f "$PROJET/.etat" ]; then
    echo "$PROJET ne ressemble pas au projet de l'exercice : je n'y touche pas."
    exit 1
fi

case "$(pwd -P)/" in
    "$(cd "$PROJET" 2>/dev/null && pwd -P)/"*)
        echo "Tu es à l'intérieur du projet. Sors-en d'abord (cd ~), puis relance."
        exit 1 ;;
esac

rm -rf "$PROJET" "$DISTANT"
echo "L'exercice a été réinitialisé."
echo
bash "$ICI/commencer.sh"
