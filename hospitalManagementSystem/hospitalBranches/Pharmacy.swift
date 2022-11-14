//
//  Pharmacy.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 01/11/22.
//

import Foundation

import Foundation

class Pharamacy
{
    public static let sharedPharmacyObject = Pharamacy()
    
    private init(){
        
    }
    
    private var medicineList: [Int:Medicine] = [101:Medicine(id: 101,name: "paracetamol", dosage: "2-T", cost: 100),
                                                102:Medicine(id: 102, name: "dolo", dosage: "1-T", cost: 250),
                                                103:Medicine(id: 103, name:"iobrufen", dosage: "2-t", cost: 105)]
    
    
    //function to initalize medicine list form json
    func initalizeMedicineList(_ list:[Int:Medicine]){
        medicineList = list
    }
    
    
    func getMedicineList()->[Int:Medicine]{
        return medicineList
    }
    
    func addMedicine(_ medicine : Medicine){
        Pharamacy.sharedPharmacyObject.medicineList[medicine.id] = medicine
    }
    
}

struct Medicine:Codable
{
    let id: Int
    let name:String
    let dosage:String
    let cost:Int
}
