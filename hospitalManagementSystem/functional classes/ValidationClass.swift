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
         emptyString = "nil or empty input",
         invalidCharacter = "only characters are allowed",
         operationCancelled
}


class Validator
{
   // validates if input is integer or nil
    static func integerValidator(_ inp: String?)throws->Int{
        
        let str = try emptyStringValidator(inp)
        guard let unwrappedIntTemp = Int(str) else {
            print(ValidationError.intTypeValueInGivenRangeExpected.rawValue)
            return try integerValidator(readLine())
            }
        return unwrappedIntTemp
    }
  
    
    //overloaded int type validator to take input till a specific closed range
    static func integerValidator(_ inp:String?,_ range: Int)throws->Int {
           
            let str = try emptyStringValidator(inp)
            if let unwrappedIntInput = Int(str){
               
                if unwrappedIntInput < range {
                    return unwrappedIntInput
                } else {
                    print(ValidationError.outOfBounds.rawValue)
                    return try integerValidator(readLine(), range)
                }
                
            } else {
                print(ValidationError.intTypeValueInGivenRangeExpected.rawValue)
                return try integerValidator(readLine(),range)
                }

    }
    
 
    
    // checks if  a string is just whitespace
    static func emptyStringValidator(_ input: String?)throws->String {
       
        guard  let un = input else {
            print(ValidationError.emptyString.rawValue)
            return  try emptyStringValidator(readLine())
       }
      
        guard  un.isEmpty == false else {
            print(ValidationError.emptyString.rawValue)
            return try emptyStringValidator(readLine())
        }
       
        guard un != "~cancel" else {
            throw ValidationError.operationCancelled
        }
            return un
    }
   
 
    //function to check if name has valid characters
    static func nameValidator(_ input: String?)throws->String
    {
        let regEx = ".*[^A-Za-z ].*"
//        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")
        let str = try emptyStringValidator(input)
         
//        print(str.range(of: regEx,options: .regularExpression))
        guard str.range(of: regEx,options: .regularExpression) == nil else {
            print(ValidationError.invalidCharacter.rawValue)
            return try nameValidator(readLine())
        }
//        guard str.rangeOfCharacter(from: set.inverted) == nil else {
//
//            print(ValidationError.invalidCharacter.rawValue)
//            return try nameValidator(readLine())
//        }
        
        return str
    }

    
   
    
    // generic function for user login
    public static func loginValidator<T: User>(_ loginList:[Int:T])throws->T {
       
        let id =    try Validator.integerValidator(readLine())
        let pass = try Validator.emptyStringValidator(readLine())
      
        guard let user = loginList[id] else {
            throw ValidationError.invalidId
        }
        
        guard user.matchPassword(password: pass) else {
            throw ValidationError.invalidPassword
            
        }
        
        return user
    }


}
