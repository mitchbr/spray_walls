cd ~/Documents/repositories/spray_walls/
flutter build web --web-renderer html --release --base-href /spray_walls/

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
git push

echo Deployed application

# rm -R ~/Documents/repositories/spray_walls_web/*
# cp -R ~/Documents/repositories/spray_walls/build/web/* ~/Documents/repositories/spray_walls_web

# cd ~/Documents/repositories/spray_walls_web
# sed '17d' index.html > temp.html
# cat temp.html > index.html
# rm temp.html

# mv assets/assets/example_wall.png assets/

# git add -A
# git commit -m "Deploying web app"
# git push --force