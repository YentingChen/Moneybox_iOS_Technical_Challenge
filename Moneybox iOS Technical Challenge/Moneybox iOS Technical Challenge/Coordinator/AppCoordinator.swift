//
//  AppCoordinator.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController?
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .app
    
    let screensProvider: AppScreensProviderProtocol
    
    private let window: UIWindow
    
    init(window: UIWindow, screensProvider: AppScreensProviderProtocol) {
        
        self.window = window
        self.screensProvider = screensProvider
    }
    
    func start() {
        
        ///Show Login flow first
        showLoginFlow()
    }
    
    func showMainFlow() {
        
        let mainFlowCoordinator = MainFlowCoordinator(window: self.window, screensProvider: screensProvider)
        
        mainFlowCoordinator.finishDelegate = self
        
        mainFlowCoordinator.start()
        
        
    }
    
    func showLoginFlow() {
        
        let loginFlowCoordinator = LoginFlowCoordinator(window: self.window, screensProvider: screensProvider)
        
        loginFlowCoordinator.finishDelegate = self
        
        loginFlowCoordinator.start()
        
    }
    
}

extension AppCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        
        /// The finished coordinator can not be in childcoordinators
        childCoordinators = childCoordinators.filter({$0.type != childCoordinator.type})
        
        switch childCoordinator.type {
            
        case .main:
            showLoginFlow()
            
        case .login:
            showMainFlow()
            
        default:
            break
        }
    }
    
}
