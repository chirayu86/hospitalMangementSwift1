//
//  Admin.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 21/10/22.
//

import Foundation



class Admin: User
{
    let name:String
    let id:Int
    let passwordHash: Int
   
    

    init(name: String, id: Int, passwordHash: Int) {
        self.name = name
        self.id = id
        self.passwordHash = passwordHash
    }
}

