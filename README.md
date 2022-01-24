# iOS Technical Challenge from Moneybox

This is an iOS Technical Challenge from Moneybox, and the details are in [here](https://github.com/MoneyBox/ios-technical-task/).

The design pattern of the app is Model-View-ViewModel-Coordinator(**MVVM-C**). I use UIKit with AutoLayout by storyboard to implement the views in the app and use the URLSession to do network data transfer tasks.
The unit tests in the project include the network and the switch of login/logout.

##  App Flow

I divide the app flow into two parts: **login flow** and **main flow**, which are under the app flow.
Users initially enter their email and password; after authenticating successfully, the app will be in the main flow, where users can conduct the app's primary functions.

I use the coordinators to control the app screen switch and the flow switch.
In the Coordinator folder you can see:

-  **Coordinator:** It contains its own child Coordinators, and the flow cycle implementing functions.

- **CoordinatorFinishDelegate**: The parent Coordinator knows when its child is ready to be finished.

- **AppScreensProviderProtocol:** It lists all the screens(UIViewController and UINavigationController) in the app.
- **Navigator:** each flow has each navigator, like in login flow, there is a LoginNavigator, which navigate the screen in the flow.

## Screens

There are screens in each flow, each screen is in the MVVM design pattern.

- **View/ViewController** display the visual elements, and each viewController contains its viewModel which contains the programming and function implementation. Due to the display being made by storyboard, so the View/Cell files are `.xib` 
- **ViewModel** receives the input from ViewController, handling all the information and logic, and then sends it back to the ViewController. It also tells to navigator to switch the screen.

## Network
- **NetworkService:** there is a loader to send the request and receive the response, and it contains the APIService.
- **APIService** to make an URLRequest and parse the response to the type that we want.

## Unit Tests
- **CoordinatorTests:** tests for switching screens.
-  **NetworkServiceTests:** tests for requesting data type and response data type.

