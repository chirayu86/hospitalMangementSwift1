//
//  recepitionist.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 22/10/22.
//

import Foundation

fileprivate struct BillingCounter
{
    static  func generateBill(_ pat: Patient,_ details:String)->Bill
    {
       var amount: Int = 0
        for prescription in pat.prescriptions
        {
            if prescription.billGenerated == false {
                for medicine in prescription.medicinesList {
                    amount += medicine.cost
                }
                for tests in prescription.testList {
                    amount += tests.cost
                }
                prescription.billGenerated = true
            }
        }
        return Bill(nameOnBill: pat.name, amount: amount, billDetails: details, billId: pat.id)
    }

}

class Reciptonist: User {
    
    let name: String
    let id: Int
    let passwordHash: Int
    
    init(name: String, id: Int, passwordHash: Int) {
        self.name = name
        self.id = id
        self.passwordHash = passwordHash
    }
    

    
    func generateBill(pat:Patient,details:String)->Bill {
        
        return BillingCounter.generateBill(pat,details)
    }
    

    func updateBill(_ amount:Int,_ bill:Bill)->String {
        
        if(bill.amount>=amount) {
            bill.amount = bill.amount - amount
            return "bill paid for amount \(amount)"
        } else {
            let change = amount - bill.amount
            bill.amount = 0
            return "return change of \(change) ruppees"
        }
    }
}

