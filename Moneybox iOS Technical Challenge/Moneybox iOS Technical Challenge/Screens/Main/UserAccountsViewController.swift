//
//  UserAccountsViewController.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import UIKit

class UserAccountsViewController: UIViewController {
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var totalPlanValueLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel: UserAccountsViewModel
    
    init(viewModel: UserAccountsViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
        
    }
    
    private func configureUI() {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapped))
        
        ///tableView
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(UINib(nibName: String(describing: InvestorproductTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: InvestorproductTableViewCell.self))
        tableView.separatorColor = .clear

    }
    
    private func bindViewModel() {
        
        viewModel.userDisplayName.bindAndFire { [weak self] text in
            self?.displayNameLabel.text = text
        }
        
        viewModel.totalPlanValue.bindAndFire { [weak self] text in
            self?.totalPlanValueLabel.text = text
        }
    }
    
}

extension UserAccountsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.didSelectAccount(index: indexPath.row)
    }
    
}
