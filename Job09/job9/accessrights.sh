#!/bin/bash

# Chemin vers le fichier CSV
csv_file="/home/youssef/Bureau/shell_exe/job9/Shell_Userlist.csv"

# Fonction pour nettoyer un nom d'utilisateur et le rendre valide
sanitize_username() {
    username="$1"
    # Supprimez les caractères non valides (par exemple, des espaces)
    username=$(echo "$username" | tr -d ',')
    # Vérifiez si le nom d'utilisateur est vide après la suppression des caractères non valides
    if [ -z "$username" ]; then
        echo "Le nom d'utilisateur est vide ou contient uniquement des caractères non valides. Ignoré."
        return 1
    fi
    echo "$username"
}

# Fonction pour créer un utilisateur avec des privilèges de super utilisateur (admin)
create_superuser() {
    username="$1"
    password="$2"

    # Nettoyer le nom d'utilisateur
    username=$(sanitize_username "$username")
    if [ $? -ne 0 ]; then
        return
    fi

    # Créer l'utilisateur
    sudo useradd -m "$username"

    # Définir le mot de passe (remplacez 'mot_de_passe' par le mot de passe souhaité)
    echo "$username:$password" | sudo chpasswd

    # Accorder des permissions d'administrateur si le rôle est "Admin"
    if [ "$role" = "Admin" ]; then
        sudo usermod -aG sudo "$username"
    fi
}

# Lire le fichier CSV ligne par ligne, en ignorant la première ligne (en-têtes)
tail -n +2 "$csv_file" | while IFS=$'\t' read -r id prenom nom password role; do
    # Vérifier si l'utilisateur existe déjà
    if id "$prenom" &>/dev/null; then
        echo "L'utilisateur $prenom existe déjà."
    else
        echo "Création de l'utilisateur $prenom avec le rôle $role."
        create_superuser "$prenom" "$password" "$role"
    fi
done

