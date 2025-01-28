DOTFILES_DIR=$1
EMAIL=$2

touch $HOME/.dbt
cp profiles.yml $HOME/.dbt/profiles.yml

echo "What is your role? (d)ata engineer or (a)nalytics engineer?"
read db_role

# Validate the input and set the role value
if [[ "$db_role" == "d" || "$db_role" == "data" || "$db_role" == "data_engineer" ]]; then
  new_role="data_engineer"
elif [[ "$db_role" == "a" || "$db_role" == "analytics" || "$db_role" == "analytics_engineer" ]]; then
  new_role="analytics_engineer"
else
  echo "Invalid role. Defaulting to Analytics Engineer."
  new_role="analytics_engineer"
fi

sed -i "" "s/\(role:\).*/\1 $new_role/" "$HOME/.dbt/profiles.yml"

# Replace the user field with the environment variable in the file
sed -i "" "/^ *user:/s/\(^ *user:\).*/\1 $EMAIL/" "$HOME/.dbt/profiles.yml"
