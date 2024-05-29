#! /bin/bash
directory="/<directry_name>"
mkdir $directory

current_date=$(date '+%Y-%m-%d')
file_name="DB-backup-${current_date}.sql"
full_path="${directory}/${file_name}"

touch $full_path
export PGPASSWORD="<db_password>"

pg_dump -h <hostname> -U <db_username> -d <db_name> -f $full_path

zip "${full_path}.zip" "$full_path"
aws s3 cp $full_path.zip <s3_path>
rm -r $directory