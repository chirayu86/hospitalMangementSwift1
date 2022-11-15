//
//  Doctor.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 20/10/22.
//
class Doctor : User {
    
    let name:String
    let id: Int
    let passwordHash: Int
    let department:String
    private var myPatientList: [Int:Patient] = [:]
    
    
    init(department: String,name:String,id:Int,Passwordhash:Int) {
        self.department = department
        self.name = name
        self.id = id
        self.passwordHash = Passwordhash
    }
    
    
    //function to prescribe test and medicine to a patient
    func prescribePatient(_ p:  Patient,prescription:Prescription){
        myPatientList[p.id] = p
        p.prescriptions.append(prescription)
    }
    
    func getPatientPreviouslyPrescribed(id: Int)->Patient?{
        return myPatientList[id]
    }
    
    //overloaded function to get all values
    func getPatientPreviouslyPrescribed()->[Int:Patient] {
        return myPatientList
    }
    

}
    
    
    
 

