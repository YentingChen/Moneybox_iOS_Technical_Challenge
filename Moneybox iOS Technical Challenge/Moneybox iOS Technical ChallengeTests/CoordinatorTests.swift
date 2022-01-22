//
//  CoordinatorTests.swift
//  Moneybox iOS Technical ChallengeTests
//
//  Created by Yenting Chen on 2022/1/22.
//

import XCTest
@testable import Moneybox_iOS_Technical_Challenge

class CoordinatorTests: XCTestCase {
    
    private lazy var appCoordinator = AppCoordinator(window: window, screensProvider: screensProvider)
    private let window =  UIWindow()
    private let screensProvider = AppCoordinatorScreensProviderMock()

    /// Test that application flow is started correctly
    func test_startsApplicationsFlow() {
        // GIVEN
        let rootViewController = UINavigationController()
        screensProvider.loginNavigationControllerReturnValue = rootViewController
        
        // WHEN
        appCoordinator.start()

        // THEN
        XCTAssertEqual(window.rootViewController, rootViewController)
    }
    
    func test_showMainFlow() {
        // GIVEN
        let rootViewController = UINavigationController()
        screensProvider.accountNavigationControllerReturnValue = rootViewController
        
        // WHEN
        appCoordinator.showMainFlow()

        // THEN
        XCTAssertEqual(window.rootViewController, rootViewController)
    }
    
    func test_showLogin() {
        // GIVEN
        let rootViewController = UINavigationController()
        screensProvider.loginNavigationControllerReturnValue = rootViewController
        
        // WHEN
        appCoordinator.showLoginFlow()
        
        // THEN
        XCTAssertEqual(window.rootViewController, rootViewController)
    }
    
    //LogoutFlow - from Main flow to Login flow
    func test_showLogoutFlow() {
        //GIVEN
        let loginNavigationViewController = UINavigationController()
        screensProvider.loginNavigationControllerReturnValue = loginNavigationViewController
        
        let mainCoordinator = MainFlowCoordinator(window: window, screensProvider: screensProvider)
        mainCoordinator.finishDelegate = appCoordinator
        
        // WHEN
        appCoordinator.coordinatorDidFinish(childCoordinator: mainCoordinator)
        
        //THEN
        XCTAssertEqual(window.rootViewController, loginNavigationViewController)
        
    }
    
    //LogoutFlow - from Login flow to Main flow
    func test_showLoginFlow() {
        //GIVEN
        let mainNavigationViewController = UINavigationController()
        screensProvider.accountNavigationControllerReturnValue = mainNavigationViewController
        
        let loginCoordinator = LoginFlowCoordinator(window: window, screensProvider: screensProvider)
        loginCoordinator.finishDelegate = appCoordinator
        
        // WHEN
        appCoordinator.coordinatorDidFinish(childCoordinator: loginCoordinator)
        
        //THEN
        XCTAssertEqual(window.rootViewController, mainNavigationViewController)
        
    }

}
