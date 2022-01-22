//
//  MainNavigator.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

/// A navigator in `Main flow`
protocol MainNavigator: AnyObject {
    
    /// Prepare to leave the main flow and do the next step
    func finishMainFlow()
    
    /// Presents the account details screen
    func showAccountDetail()
}

