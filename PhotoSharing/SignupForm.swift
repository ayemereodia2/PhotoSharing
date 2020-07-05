//
//  SignupForm.swift
//  PhotoSharing
//
//  Created by Ayemere  Odia  on 02/07/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation

class SignupForm {
    
    func isFirstNameValid(firstname:String)->Bool{
        var isValid = true

        if let _ = firstname.range(of: ".*[^A-Za-z].*", options: .regularExpression)  {
            isValid = false
        }
        
        
        if firstname.count < PhotoConstants.minLength || firstname.count > PhotoConstants.maxLength {
            isValid = false
        }
        return isValid
    }
    
    
    func isPasswordValid(password:String)->Bool{
        var isValid = false
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,25}"
        if let _ = password.range(of: regex, options: .regularExpression)  {
                   isValid = true
               }
        
        if password.count < 8 {
            isValid = false
        }
        return isValid
    }
    
    
}
