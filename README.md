# Flutter News App

## Overview
  Flutter app for viewing articles with the ability to browse by category and most popular entries using the News API

## Configuration
  1. Download the contents of this repository.
  2. Rename the “.env.example” file to “.env”.
  3. Save your API key generated [here](https://newsapi.org/) in the .env file.
  4. Download all dependencies using the **“dart pub get”** command.
  5. Generate the file containing your API key using **“dart run build_runner clean”** and **“dart run build_runner build --delete-conflicting-outputs”** commands as instructed [here](https://pub.dev/packages/envied).

> [!NOTE] 
> To use data from the API, change the value of the **"testing"** variable in the **Configuration** class to **false**, otherwise the application will use locally generated data.
