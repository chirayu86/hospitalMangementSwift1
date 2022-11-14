//
//  database.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 07/11/22.
//

import Foundation
class DataBase
{
    
    static let sharedDb = DataBase()
    
    
    private init()
    {
    }
    
    private var billList: [Int:Bill] = [:]

    private var patientDictonary: [Int:Patient] = [:]
   
    private var doctorDictonary: [Int:Doctor] = [:]
  
    private var adminDictonary: [Int:Admin] = [001:Admin(name: "rahul", id: 001, passwordHash: 918)]
   
    private var reciptonistDictonary: [Int:Reciptonist] = [401:Reciptonist(name: "sohel", id: 401, passwordHash: 918)]
    
    private var pharmacistDictonary: [Int:Pharmacist] = [501:Pharmacist(name: "bhargav", id: 501, passwordHash: 918)]
   
    //method to initalize dataBase from json files
    func initalizeDatabase(_ patients:[Int:Patient],_ doctors:[Int:Doctor])
    {
        patientDictonary = patients
        doctorDictonary = doctors
    }
    
    //methods the get the entire user list
    func getPatientList()->[Int:Patient] {
        return patientDictonary
    }
    
    func getDoctorList()->[Int:Doctor]{
        return doctorDictonary
        
    }
   
    func getAdminList()->[Int:Admin]{
        return adminDictonary
         
    }
 
    func getReciptonistList()->[Int:Reciptonist]{
        return reciptonistDictonary
        
    }
   
    func getPharamcistList()->[Int:Pharmacist]{
        return pharmacistDictonary
        
    }
   
    //methods to get a single user
    func getPatientFromDatabase(userId:Int)-> Patient?{
        return patientDictonary[userId]
        
    }
    
    func getDoctorFromDatabase(userId:Int)-> Doctor?{
        return doctorDictonary[userId]
        
    }
    
    func getAdminFromDatabase(userId:Int)->Admin?{
        return adminDictonary[userId]
         
    }
    
    func getRecptionistFromDatabase(userId:Int)->Reciptonist?{
        return reciptonistDictonary[userId]
        
    }
    
    
    //misc getter methods
    func getBill(_ billId: Int)->Bill?{
        return billList[billId]
        
    }
    
    // add to database methods
    func storePatientToDatabase(_ patient: Patient){
        patientDictonary[patient.id] = patient
        
    }
    
    func storeDoctorToDataBase(_ doctor: Doctor){
        doctorDictonary[doctor.id] = doctor
        
    }
    
    func storeAdminToDatabase(_ admin: Admin){
        adminDictonary[admin.id] = admin
        
    }
    
    func storeReciptonistToDatabase(_ rec: Reciptonist){
        reciptonistDictonary[rec.id] = rec
        
    }
    
    func storeBillToDatabase(_ bill:Bill){
        billList[bill.id] = bill
        
    }
    
    
     
    //remove user from database methods
    func removePatientFromDataBase(_ id:Int){
        patientDictonary.removeValue(forKey: id)
        
    }
    
    func removeDoctorFromDatabase(_ id:Int){
        doctorDictonary.removeValue(forKey: id)
        
    }
    
    
}
