# Rsponsive News APP
A Responsive Flutter News Application that fetch Daily News with Restful API


## Overview
This App fetch news update from the internet. it's a responsive app that support web and Mobile(Android and IOS).

## Preview

![ScreenShot](https://github.com/shittu33/ResponsiveNewsApp/blob/master/screen.PNG?raw=true)


## Moltivation
Flutter is a great because of it cross platform hotReload solution, i just think it will be a great idea to write one codebase News App that can run both on my PC and phone, and also filter those update to fit my need.


## Technologies
**This project fetch its data from:**
* [News API](https://newsapi.org)

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

## Download
**Run the App on your brower with this link:**
https://shittu33.github.io/ResponsiveNewsApp
**Download the APK with this link:**

## Setup
* Clone the repository
* run flutter pub get command
* Got to [News API](https://newsapi.org) website, create an account an optain your APi key
* inside the /lib folder create a file named config.dart and place the following code:
``` Dart
const NEWS_API_KEY = "PASTE_YOUR_API_KEY_HERE";
```
* After that just go to your terminal and type this command: 
```cmd
flutter pub run build_runner build
```
* If everything goes fine, you can now build and run the App!!!
