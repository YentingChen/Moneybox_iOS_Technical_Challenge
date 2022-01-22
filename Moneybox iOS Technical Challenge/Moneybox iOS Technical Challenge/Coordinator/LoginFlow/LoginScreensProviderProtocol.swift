//
//  LoginScreensProviderProtocol.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import UIKit


/// Shows the screens in login flow
protocol LoginScreensProviderProtocol: AnyObject {
    
    /// Creates UINavigationController to display the first login screen in longin flow
    /// - Returns: `UINavigationController`
    /// - Parameters: `LoginNaviator` to indicate the next action
    func loginNavigationController(navigator: LoginNavigator) -> UINavigationController
    
}
