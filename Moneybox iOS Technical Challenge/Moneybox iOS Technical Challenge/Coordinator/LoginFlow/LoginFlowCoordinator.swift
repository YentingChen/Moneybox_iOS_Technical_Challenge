//
//  LoginFlowCoordinator.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import UIKit


class LoginFlowCoordinator: Coordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController?
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .login
    
    private let window: UIWindow
    
    let screensProvider: LoginScreensProviderProtocol
    
    init(window: UIWindow, screensProvider: LoginScreensProviderProtocol) {
        
        self.window = window
        
        self.screensProvider = screensProvider
    }
    
    func start() {
        
        let navigationController =  screensProvider.loginNavigationController(navigator: self)
        self.navigationController = navigationController
        self.window.rootViewController = navigationController
        
    }
    
    func finish() {
        
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
}

extension LoginFlowCoordinator: LoginNavigator {
    
    func finishLoginFlow() {
        
        finish()
        
    }
    
}
