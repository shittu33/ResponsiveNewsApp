# Rsponsive News APP
A Responsive Flutter News Application that fetch Daily News with Restful API


## Overview
This App fetch news update from the internet. it's a responsive app that support web and Mobile(Android and IOS).

## Preview

![ScreenShot](https://github.com/shittu33/ResponsiveNewsApp/blob/master/screen.PNG?raw=true)

## Demo

https://youtu.be/0cqSNDhN_OQ

## Moltivation
Flutter is a great because of it cross platform hotReload solution, i just think it will be a great idea to write one codebase News App that can run both on my PC and phone, and also filter those update to fit my need.


## Technologies
**This project fetch its data from:**
*https://abdulmujeeb-nodejs-news.herokuapp.com/
**The above Api was built using the following**
*Node.js
*Express
*body-parser
*[News API](https://newsapi.org)
*the source code for the Api server can be found  [here](https://newsapi.org)

**I used following SDK:**
* Flutter SDK
* Android SDK

**I used following main packages:**
* retrofit
* retrofit_generator: any
* build_runner: any
* json_serializable:
*  google_fonts:
*  country_code:
*  flag:

## Pattern
* Bloc pattern


## Features
* Load News update
* Filter News by category(e.g buisness,sport and entertainment News)
* Filter News by Country
* Filter News by Source(e.g bbc and abc News)
* Filter News by Tag


## Install && Run the App on your device

## Run the App on your brower with this link:
https://shittu33.github.io/ResponsiveNewsApp 

### APK
instead Download the raw APK by clicking
[here](https://github.com/shittu33/ResponsiveNewsApp/blob/master/news.apk)



## Build your own News App

* Clone the repository
```cmd
git clone https://github.com/shittu33/ResponsiveNewsApp
```
* run flutter pub get command in your terminal
```cmd
flutter pub get
```
* Got to [News API](https://newsapi.org) website, create an account and optain your APi key
* inside the /lib folder create a file named config.dart and place the following code:
``` Dart
const NEWS_API_KEY = "PASTE_YOUR_API_KEY_HERE";
```
* After that just go to your terminal and type this command: 
```cmd
flutter pub run build_runner build
```
* If everything goes fine, you can now build and run the App!!!

# Licence

  
MIT License

Copyright (c) 2020 AbdulMujeeb Olawale

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
