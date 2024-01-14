mkdir -p ~/projects
mkdir -p ~/reviews

while read -r repo;
do
  git -C ~/projects clone $repo
done < .repositories
