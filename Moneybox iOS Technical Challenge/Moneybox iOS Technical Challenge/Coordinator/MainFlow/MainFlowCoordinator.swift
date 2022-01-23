//
//  MainFlowCoordinator.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation
import UIKit

class MainFlowCoordinator: Coordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController?
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    let screensProvider: MainScreensProviderProtocol
    
    var type: CoordinatorType = .main
    
    init(window: UIWindow, screensProvider: MainScreensProviderProtocol) {
        self.window = window
        self.screensProvider = screensProvider
    }
    
    func start() {
        
        let mainNavagationController = screensProvider.accountNavigationController(navigator: self)
        
        self.navigationController = mainNavagationController
        
        self.window.rootViewController = mainNavagationController
        
    }
    
}

extension MainFlowCoordinator: MainNavigator {
    
    func finishMainFlow() {
        
        finish()
        
    }
    
    func showAccountDetail(product: ProductResponse) {
        
        let vc = screensProvider.accountDetailsController(product: product)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



