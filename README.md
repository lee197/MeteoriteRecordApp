# MeteoriteRecordApp
An app to display a list of fallen meteors on Earth since 1900.

## Branches:

* master - stable app releases
* develop - development branch, merge features branches here

## Articles API:

* Articles sorted by emailed: https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi
* Articles sorted by shared: https://api.nytimes.com/svc/mostpopular/v2/shared/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi
* Articles sorted by viewed: https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi

## Dependencies:

The project is not using cocoapods for managing external libraries and a Gemfile for managing the cocoapods version.

In case you need to use cocoapods, please follow the instructions: 

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

## Project structure:



## Next step:

*  optimize the unit test

## Author:

*  Qi Li

## Contact:

* https://www.linkedin.com/in/lee-qi/
* www.leeqii.com
