# Creates the database and verifies that things work.
mysql -u mothy --local-infile=1 < ../sql/database-backup.sql
