#!/bin/bash

# Fonction pour créer un utilisateur
function create_user {
    read -p "Entrez le nom de l'utilisateur à créer : " user_name
    if id "$user_name" &>/dev/null; then
       echo "L'utilisateur '$user_name' existe déjà."
    else

       # Demander le mot de passe
       read -sp "Entrez le mot de passe pour l'utilisateur '$user_name' : " password
       echo

       # Créer l'utilisateur
       useradd -m -p "$(openssl passwd -1 '$password')" "$user_name"

       # Afficher un message de confirmation
       echo "Utilisateur '$user_name' créé avec succès."
    fi
}


# Fonction pour supprimer un utilisareur
function delete_user {
    
    read -p "Entrez le nom de l'utilisateur à supprimer : " user_name

    # Vérifier si l'utilisateur existe
    if id "$user_name" &>/dev/null; then
 
       # Supprimer l'utilisateur
       userdel -r "$user_name"
       echo "L'utilisateur '$user_name' a été supprimé avec succès."

    else
         echo "L'utilisateur '$user_name' n'existe pas."
         echo "Erreur lors de la supprission"
    fi
}


# Menu principal
while true; do
    echo "Menu de gestion des utilisateurs"
    echo "1. Créer un utilisateur "
    echo "2. Supprimer un utilisateur"
    echo "3. Quitter"
    read -p "Choisissez une option [1-3] : " choix

    case $choix in
        1)
            create_user 
            ;;
        2)
            delete_user
            ;;
        3)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix invalide, veuillez réessayer."
            ;;
    esac

    echo ""
done
