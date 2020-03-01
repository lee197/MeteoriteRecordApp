# MeteoriteRecordApp
An app to display a list of fallen meteors on Earth since 1900.

## Branches:

* master - stable app releases
* develop - development branch, merge your feature branches here

## Dependencies:

The project is using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version.

Installation
```
$ sudo gem install cocoapods
```

Create a pod file in your Xcode project directory:
```
$ pod init
```

Then install the pods in your Xcode project directory:
```
$ pod install
```

## Core Dependencies:

Alamofire: an HTTP networking library written in Swift.

## Project structure:

* ViewModel: viewmodel objects
* Model: model objects
* Networking Service: contains APIService and API json file for testing

## Next step:

*  Replace UIStoryboard with AutoLayout code
*  Make Generic Networking Layer or install Moya Networking pod
