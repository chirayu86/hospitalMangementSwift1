//
//  Bill.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 25/10/22.
//

import Foundation

class Bill:Codable
{
    let nameOnBill: String
    var amount : Int
    let details : String
    let id : Int
    
    
    init(nameOnBill: String, amount: Int, billDetails: String, billId: Int) {
        
        self.nameOnBill = nameOnBill
        self.amount = amount
        self.details = billDetails
        self.id = billId
    }
   
}


