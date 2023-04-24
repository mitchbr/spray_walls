cd ~/Documents/repositories/spray_walls/
flutter build web --web-renderer html --release # --base-href /spray_walls/

rm -r ./docs/*
mv ./build/web/* ./docs
mv ./docs/assets/assets/example_wall.png ./docs/assets/
rm -rf ./docs/assets/assets

sed '17d' ./docs/index.html > ./docs/temp.html
cat ./docs/temp.html > ./docs/index.html
rm ./docs/temp.html

read -p "Enter commit message: " message

git add -A
git commit -m "$message"

read -p "Successfully built and committed, deploy now? (y/n) " deployment

if [[ "$deployment" == "y" ]]; then
  git push
  echo "Deployed application"
else
  echo "Aborting push to github"
fi
