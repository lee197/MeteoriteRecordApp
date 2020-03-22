# MeteoriteRecordApp
An app to display a list of fallen meteors on Earth since 1900.

## Branches:

* master - stable app releases
* develop - development branch, merge features branches here

## Project structure:

* ViewModel: viewmodel objects with all business logic
* Model: data model objects
* Repository: mediate layer between Data source and Viewmodels
* Networking Service: Generic Networking Layer
* DB: Generic DB Layer
* Uint test: test the all functions in viewmodel with mocked networking service

## Next step:

*  add Heading and post function to the Generic networking Layer
