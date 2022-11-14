//
//  Pharmacist.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 08/11/22.
//

import Foundation

class Pharmacist:User
{
    let name: String
    let id: Int
    let passwordHash: Int
    
    func addMedicine(_ medicine: Medicine){
        
        Pharamacy.sharedPharmacyObject.addMedicine(medicine)
    }

    init(name: String, id: Int, passwordHash: Int) {
        self.name = name
        self.id = id
        self.passwordHash = passwordHash
    }
}
