//
//  Coordinator.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    var navigationController: UINavigationController? { get set }
    
    /// Array to keep tracking of all child coordinators.
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    
    func finish()
    
    /// Defined flow type.
    var type: CoordinatorType { get }
}

extension Coordinator {
    
    func finish() {
        
        childCoordinators.removeAll()
        
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// MARK: - CoordinatorType
/// Using this structure we can define what type of flow we can use in-app.
enum CoordinatorType {
    case app, login, main
}
