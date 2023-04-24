cd ~/Documents/repositories/spray_walls/
flutter build web --web-renderer html --release --base-href /spray_walls/

mv ./build/web ./docs
mv ./docs/assets/assets/example_wall.png ./docs/assets/

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