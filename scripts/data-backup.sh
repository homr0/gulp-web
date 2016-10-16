# Backs up the data into .csv files and moves it into the data directory for SQL stuff.
sudo rm /tmp/*.csv # Removes any existing .csv files.
mysql -u mothy < ../sql/database-backup.sql
sudo mv /tmp/*.csv ../sql/data/
