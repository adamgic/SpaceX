# SpaceX

Simple iOS client application for consuming SpaceX API.

### Dependencies

**No dependencies!** Using only iOS SDK.

## Description

iOS client application, consuming API from SpaceX available [here](https://api.spacexdata.com/v2/launches/). Simple architecture explaining the purpose of the project. Presenting informations about rocket launches.

### Covered topics

- use of **UIKit** components
- **URLSession** to perform API calls
- **Decodable** protocol to decode JSON
- **XCTest** for Unit Testing and UI Testing
- use of **DateFormatter** to get local time and UTC
- **Foundation** and **swift 4**

### Features

List of available launches providing information about

- mission patch
- flight number
- rocket name
- launch date
- launch site
- visual indicator describing launch success

![content](doc/content.png)

Data presented in **UITableView** with option of filtering with respect to launch success.

Details view of a launch providing information about

- details of the mission
- UTC launch time
- local launch time
- payloads
- links placed in **UIStackView** dynamically, allowing user to browse the content

![details](doc/details.png)

Web content browsing using **SFSafariViewController**.

![web](doc/web.png)

Unit Test for parsing JSON file. UI Test navigating through the appilication.
