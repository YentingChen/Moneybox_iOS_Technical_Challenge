//
//  AppCoordinatorScreensProviderMock.swift
//  Moneybox iOS Technical ChallengeTests
//
//  Created by Yenting Chen on 2022/1/22.
//

@testable import Moneybox_iOS_Technical_Challenge
import UIKit

class AppCoordinatorScreensProviderMock: AppScreensProviderProtocol {
    
    var accountNavigationControllerReturnValue: UINavigationController?
    func accountNavigationController(navigator: MainNavigator) -> UINavigationController {
        return accountNavigationControllerReturnValue!
    }
    
    var accountDetailsControllerReturnValue: UIViewController?
    func accountDetailsController() -> UIViewController {
        return accountDetailsControllerReturnValue!
    }
    
    var loginNavigationControllerReturnValue: UINavigationController?
    func loginNavigationController(navigator: LoginNavigator) -> UINavigationController {
        return loginNavigationControllerReturnValue!
    }

}
