//
//  MainScreensProviderProtocol.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

/// Shows the screens in `Main flow`
protocol MainScreensProviderProtocol: AnyObject {
    
    /// Creates UINavigationController to display the first login screen in main flow
    /// - Returns: `UINavigationController`
    /// - Parameters: `MainNavigator` to indicate the next action
    func accountNavigationController(navigator: MainNavigator) -> UINavigationController
    
    // Creates UIViewController to show the details of the account
    func accountDetailsController() -> UIViewController
    
}
