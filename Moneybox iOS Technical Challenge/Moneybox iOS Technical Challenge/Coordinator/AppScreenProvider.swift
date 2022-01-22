//
//  AppScreenProvider.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation
import UIKit


/// Shows the  screens in the App
protocol AppScreensProviderProtocol: LoginScreensProviderProtocol, MainScreensProviderProtocol {}

class AppScreensProvider: AppScreensProviderProtocol {
    
    //MARK: - Login Flow
    func loginNavigationController(navigator: LoginNavigator) -> UINavigationController {
        
        let vm = LoginViewModel()
        let vc = LoginViewController(viewModel: vm)
        vc.title = "Login"
        let loginNavigationController = UINavigationController(rootViewController: vc)
        
        return loginNavigationController
    }
    
    //MARK: - Main Flow
    func accountNavigationController(navigator: MainNavigator) -> UINavigationController {
        return UINavigationController()
    }
    
    func accountDetailsController() -> UIViewController {
        return UIViewController()
    }
    
}
