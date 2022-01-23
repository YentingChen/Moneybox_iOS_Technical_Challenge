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
        
        let vm = LoginViewModel(navigator: navigator)
        let vc = LoginViewController(viewModel: vm)
        vc.title = "Login"
        let loginNavigationController = UINavigationController(rootViewController: vc)
        
        return loginNavigationController
    }
    
    //MARK: - Main Flow
    func accountNavigationController(navigator: MainNavigator) -> UINavigationController {
        
        let vm = UserAccountsViewModel(navigator: navigator)
        let vc = UserAccountsViewController(viewModel: vm)
        vc.title = "User Accounts"
        let mainNavigationController = UINavigationController(rootViewController: vc)
        
        return mainNavigationController
    }
    
    func accountDetailsController(product: ProductResponse) -> UIViewController {
        
        let vm = UserAccountDetailViewModel(detail: product)
        let vc = UserAccountDetailViewController(viewModel: vm)
        vc.title = "Individual Account"
        return vc
    }
    
}
