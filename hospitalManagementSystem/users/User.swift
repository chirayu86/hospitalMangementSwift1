//
//  login_users.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 14/10/22.
//

import Foundation


protocol User : Codable {
    
    var name: String {get}
    var id:Int{get}
    var passwordHash:Int {get}
    
    func matchPassword(password:String)->Bool
    
}


extension User {
    
    func matchPassword(password: String) -> Bool {
    
        return password.hash == self.passwordHash
   
    }
    
}




