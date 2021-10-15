//
//  String + Extension.swift
//  JuniorTestTaskProject
//
//  Created by Pavel Olegovich on 14.10.2021.
//

import Foundation

extension String {

    enum  ValidTypes {
        case name
        case email
//        case phone
        case password
    }
    
    enum Regex: String {
        case name = "[а-яА-Я]{1,}"
        case email = "[a-zA-Z0-9._-]+@[a-zA-Z]+\\.[a-zA-Z]{2,}"
//        case phone = "[+]{1,}+[7]{1,}+[0-9]{10,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
//        case .phone: regex = Regex.phone.rawValue
        case .password: regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}

