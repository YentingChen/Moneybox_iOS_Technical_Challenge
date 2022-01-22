//
//  LoginNavigator.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//


/// A navigator in `Login flow`
protocol LoginNavigator: AnyObject {
    
    /// Prepare to leave the login flow and do the next step
    func finishLoginFlow()
}

