#!/bin/bash

chuck=$(curl https://api.chucknorris.io/jokes/random --silent | jq '.value')
catURL=$(curl https://api.thecatapi.com/v1/images/search --silent | jq '.[0].url' | tr -d '"')

curl $catURL --silent > cat.jpg

catimg ./cat.jpg
echo $chuck

rm ./cat.jpg
