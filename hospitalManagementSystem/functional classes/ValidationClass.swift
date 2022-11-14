//
//  LoginManager.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 17/10/22.
//

import Foundation



enum ValidationError:String,Error
{
    case invalidPassword,
         invalidId,
         intTypeValueInGivenRangeExpected = "pls enter a valid integer input",
         outOfBounds = "enter value in correct range",
         noAssociatedValueFound,
         emptyString = "nil or empty input"
}


class Validator
{
   // validates if input is integer or nil
    static func intTypeValidator(_ inp: String?)->Int{
        
        let str = stringTypeValidator(inp)
        guard let unwrappedIntTemp = Int(str) else {
            print(ValidationError.intTypeValueInGivenRangeExpected.rawValue)
            return intTypeValidator(readLine())
            }
        return unwrappedIntTemp
    }
  
    
    //overloaded int type validator to take input till a specific closed range
    static func intTypeValidator(_ inp:String?,_ range: Int)->Int {
           
            let str = stringTypeValidator(inp)
            if let unwrappedIntInput = Int(str){
               
                if unwrappedIntInput < range {
                    return unwrappedIntInput
                } else {
                    print(ValidationError.outOfBounds.rawValue)
                    return intTypeValidator(readLine(), range)
                }
                
            } else {
                print(ValidationError.intTypeValueInGivenRangeExpected.rawValue)
                return intTypeValidator(readLine(),range)
                }

    }
    
 
    
    // checks if  a string is just whitespace
    static func stringTypeValidator(_ input: String?)->String {
       
        guard  let un = input else {
            print(ValidationError.emptyString.rawValue)
            return  stringTypeValidator(readLine())
       }
        guard  un.isEmpty == false else
        {
            print(ValidationError.emptyString.rawValue)
            return stringTypeValidator(readLine())
        }
            return un
    }
   

    
    // generic function for user login
    public static func loginValidator<T: User>(_ loginList:[Int:T])throws->T {
       
        let id =    Validator.intTypeValidator(readLine())
        let pass =  Validator.stringTypeValidator(readLine())
        guard let user = loginList[id] else {
            throw ValidationError.invalidId
            
        }
        
        guard user.matchPassword(password: pass) else {
            throw ValidationError.invalidPassword
            
        }
        
        return user
    }


  
    
    
}
