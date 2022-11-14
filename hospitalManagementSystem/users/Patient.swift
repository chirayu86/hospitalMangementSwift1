//
//  Patient.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 20/10/22.
//


class Patient : User
{
    let name:String
    let passwordHash: Int
    let id:Int
    let age:Int
    let inDate:String
    var prescriptions: [Prescription]

   
    init(age:Int,date:String,name:String,id:Int,passwordHash:Int)
    {
        self.age = age
        self.inDate = date
        self.prescriptions = []
        self.name = name
        self.passwordHash = passwordHash
        self.id = id

    }
    

}


