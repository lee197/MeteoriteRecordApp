# MeteoriteRecordApp
An app to display a list of fallen meteors on Earth since 1900.

## NASA METEORITE API:

* View: https://data.nasa.gov/view/ak9y-cwf9
* Documentation: https://dev.socrata.com/foundry/data.nasa.gov/y77d-th95
* Json: https://data.nasa.gov/resource/y77d-th95.json
* Administration: https://data.nasa.gov/login

## Branches:

* master - stable app releases
* develop - development branch, merge features branches here

## Project structure:

<p align="center">
  <img src="MVVM%20structure.png" />
</p>

* ViewModel: viewmodel objects with all business logic
* Model: data model objects
* Repository: mediate layer between Data source and Viewmodels
* Networking Service: Generic Networking Layer
* DB: Generic DB Layer
* Uint test: test the all functions in viewmodel with mocked networking service

## Next step:

*  optimize the unit test
