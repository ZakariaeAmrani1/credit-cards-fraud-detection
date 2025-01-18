notes_path=$1

while true; do
echo "1. Ajouter une note !"
echo "2. Modifier une note !"
echo "3. Supprimer une note !"
echo "4. Afficher tous les notes !"
echo "5. Rechercher une note !"
echo "6. Quitter !"
read choice

case $choice in
        1)
         echo -n "Entrez votre note : "
        read note
        echo "$note" >> "$notes_path"
        echo "Note ajoutée avec succès."
        ;;
        2)
        echo "Numéro de la note à modifier :"
        select note in $(cat "$notes_path"); do
        if [ -n "$note" ]; then
            echo "Note sélectionnée : $note"
            echo -n "Entrez la nouvelle note : "
            read new_note
           sed -i "s/^$note$/$new_note/" "$notes_path"
            echo "Note modifiée avec succès."
            break
        else
            echo "Sélection invalide. Essayez encore."
        fi
        done
        ;;
        3)
        echo "Numéro de la note à supprimer :"
        select note in $(cat "$notes_path"); do
        if [ -n "$note" ]; then
            sed -i "/^$note$/d" "$notes_path"
            echo "Note supprimée avec succès."
            break
        else
            echo "Sélection invalide. Essayez encore."
        fi
        done
        ;;
        4)
        if [ -s "$notes_path" ]; then
                echo "Liste des notes :"
                cat "$notes_path"
        else
                echo "Aucune note enregistrée."
        fi
        ;;
        5)
        echo -n "Entrez le mot-clé à rechercher : "
        read word
        results=$(grep -i "$word" "$notes_path")
        if [ -n "$results" ]; then
                echo "Notes trouvées :"
                echo "$results"
        else
                echo "Aucune note ne correspond au mot-clé '$word'."
        fi
        ;;
        6) echo "Au revoir!" && exit 0 ;;
        *) echo "Option invalide. Veuillez choisir une option entre 1 et 5." ;;
esac
done