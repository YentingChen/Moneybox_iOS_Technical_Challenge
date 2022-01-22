//
//  LoginViewController.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, SingleButtonDialogPresenter {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingIndicatorView: LoadingIndicatorView!
    let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        configureUI()
        
        emailTextField.text = "test+ios@moneyboxapp.com"
        passwordTextField.text = "P455word12"
        viewModel.emailInput.value = emailTextField.text
        
        viewModel.passwordInput.value = passwordTextField.text
        
    }
    
    func bindViewModel() {
        
        viewModel.buttonIsSendableOutput.bindAndFire { [weak self] isSendable in
            
            self?.loginButton.isEnabled = isSendable
            
        }
        
        viewModel.showLoadingIndicator.bindAndFire { [weak self] showIndicator in
            
            DispatchQueue.main.async {
                
                self?.loadingIndicatorView.isHidden = !showIndicator
            }
            
        }
        
        viewModel.hideKeyboard = { [weak self] in
            
            self?.emailTextField.resignFirstResponder()
            self?.passwordTextField.resignFirstResponder()
            
        }
        
        viewModel.showAlert = { [weak self] alert in
            
            self?.presentSingleButtonDialog(alert: alert)
            
        }
        
    }
    
    private func configureUI() {
        
        passwordTextField.isSecureTextEntry = true
        
        ///Add Target
        loginButton.addTarget(self, action: #selector(loginButtonTapped(sender:)), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(emailChanged(sender:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordChanged(sender:)), for: .editingChanged)
        
    }
    
    @objc func emailChanged(sender: UITextField) {
        
        viewModel.emailInput.value = sender.text
        
    }
    
    @objc func passwordChanged(sender: UITextField) {
        
        viewModel.passwordInput.value = sender.text
        
    }
    
    @objc func loginButtonTapped(sender: UIButton) {
        
        viewModel.loginButtonDidTapped()
        
    }
    
}
