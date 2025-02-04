DOTFILES_DIR=$1
EMAIL=$2
PROFILES="$HOME/.dbt/profiles.yml"

first_char="${EMAIL%%.*:0:1}"
first_char="${first_char:0:1}"
second_word="${EMAIL#*.}"
second_word="${second_word%%@*}"
SCHEMA="${first_char}${second_word}"

touch $HOME/.dbt
cp profiles.yml $PROFILES

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

sed -i "" "s/\(role:\).*/\1 $new_role/" "$PROFILES"
sed -i '' "s/^\([[:space:]]*schema:[[:space:]]*\).*/\1${SCHEMA}/" "$PROFILES"
# Replace the user field with the environment variable in the file
sed -i "" "/^ *user:/s/\(^ *user:\).*/\1 $EMAIL/" "$PROFILES"

echo "Updated dbt profile.yml."
