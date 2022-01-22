//
//  Bindable.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/22.
//

import Foundation

class Bindable<T> {
    
    typealias Listener = ((T) -> Void)
    
    var listener: Listener?
    
    var value: T {
        
        didSet {
            
            listener?(value)
            
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
