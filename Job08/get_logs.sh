# Répertoire de destination pour les fichiers archivés
backup_dir=~/Job8:Backup

# Obtenez la date actuelle au format jj-mm-aaaa-HH:MM
current_date=$(date +"%d-%m-%Y-%H:%M")

# Obtenez le nom de l'utilisateur à surveiller (remplacez 'utilisateur_cible' par le nom de l'utilisateur)
target_user=utilisateur_cible

# Comptez le nombre de connexions de l'utilisateur
connection_count=$(grep "$target_user" /var/log/auth.log | grep "Accepted password" | wc -l)

# Créez le fichier contenant le nombre de connexions
filename="number_connection-$current_date"
echo "$connection_count" > "$filename"

# Archivez le fichier
tar -cf "$filename.tar" "$filename"

# Déplacez le fichier archivé vers le répertoire de sauvegarde
mv "$filename.tar" "$backup_dir/$filename.tar"
