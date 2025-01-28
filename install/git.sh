printf "Insert name for git configuration: "
read github_name
git config --global user.name $github_name

printf "Insert NDR email for git configuration: "
read github_email
git config --global user.email $github_email

git config --global pull.rebase true

export github_email=$github_email
