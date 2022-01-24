//
//  LoginViewModelTests.swift
//  Moneybox iOS Technical ChallengeTests
//
//  Created by Yenting Chen on 2022/1/22.
//

import XCTest
@testable import Moneybox_iOS_Technical_Challenge

class LoginViewModelTests: XCTestCase {
    
    let mockNavigator = MockNavigator()
    let mockAuth = MockAuth()
    lazy var viewModel = LoginViewModel(navigator: mockNavigator, authService: mockAuth)

    func test_ButtonIsSendable() throws {
        ///GIVEN
        let isSenable = viewModel.buttonIsSendableOutput.value
        
        ///WHEN
        viewModel.checkIsSendable(email: "123", password: nil)
        
        ///THEN
        XCTAssertEqual(isSenable, false)
    }
    
    func test_LoginSuccess() {
        
        ///GIVEN
        let user = User(userID: "1234", firstName: "Mike", lastName: "Brown")
        let session = Session(bearerToken: "I am token")
        let mockResponse = LoginResponse(user: user, session: session)
        
        ///WHEN
        viewModel.loginSuccess(mockResponse)
        
        ///THEN
        XCTAssert(mockNavigator.finishLoginFlowIsCalled)
        XCTAssertEqual(mockAuth.userDisplayName, user.firstName)
        XCTAssertEqual(mockAuth.bearerToken, session.bearerToken)
        
    }

    

}

class MockNavigator: LoginNavigator {
    
    var finishLoginFlowIsCalled = false
    func finishLoginFlow() {
        finishLoginFlowIsCalled = true
    }

}



class MockAuth: AuthServiceType {
    
    var userDisplayName: String?
    
    var bearerToken: String?
    
}
