# MeteoriteRecordApp
An app to display a list of fallen meteors on Earth since 1900.

## Branches:

* master - stable app releases
* develop - development branch, merge features branches here

## NASA METEORITE API:

* View: https://data.nasa.gov/view/ak9y-cwf9
* Documentation: https://dev.socrata.com/foundry/data.nasa.gov/y77d-th95
* Json: https://data.nasa.gov/resource/y77d-th95.json
* Administration: https://data.nasa.gov/login

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

*  Make Generic Networking Layer or install Moya Networking pod
