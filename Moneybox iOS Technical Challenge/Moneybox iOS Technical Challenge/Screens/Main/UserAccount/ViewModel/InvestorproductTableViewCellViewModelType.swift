//
//  InvestorproductTableViewCellViewModelType.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

protocol InvestorproductTableViewCellViewModelType {
    
    var productNameLabelText: String? { get }
    var planValueLabelText: String? { get }
    var moneyBoxLabelText: String? { get }
}

extension ProductResponse: InvestorproductTableViewCellViewModelType {
    var productNameLabelText: String? {
        
        return product?.friendlyName ?? "N/A"
        
    }
    
    var planValueLabelText: String? {
        
        if let planValue = planValue {
            
            return "Plan Value: £\(planValue)"
            
        } else {
            
            return "Plan Value: £N/A"
        }
        
    }
    
    var moneyBoxLabelText: String? {
        
        if let moneybox = moneybox {
            
            return "Money box: £\(moneybox)"
            
        } else {
            
            return "Money box: £N/A"
        }
        
    }
    
    
}



