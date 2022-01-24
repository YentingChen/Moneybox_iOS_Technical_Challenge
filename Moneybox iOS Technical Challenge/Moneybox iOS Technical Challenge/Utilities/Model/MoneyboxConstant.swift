//
//  MoneyboxConstant.swift
//  Moneybox iOS Technical Challenge
//
//  Created by Yenting Chen on 2022/1/23.
//

struct MoneyboxConstant {
    
    //Network
    static let host: String = "api-test02.moneyboxapp.com"
    static let appIdKey: String = "AppId"
    static let appIdValue: String = "8cb2237d0679ca88db6464"
    static let contentTypeKey: String = "Content-Type"
    static let contentTypeValue: String = "application/json"
    static let appVersionKey: String = "appVersion"
    static let appVersionValue: String = "7.10.0"
    static let apiVersionKey: String = "apiVersion"
    static let apiVersionValue: String = "3.0.0"
    
    //Other
    static func totalPlanValueText(value: Double?) -> String {
        
        if value == nil {
            return "Total Plan Value: £--"
        } else {
            return "Total Plan Value: £\(value!)"
        }
        
    }
    
    static func greetingUserdisplayname(name: String?) -> String {
        
        return "Hi \(name ?? "--")!"
    }
                
   
}

extension String {
    
    static let error = "Error"
    static let ok = "OK"
}
