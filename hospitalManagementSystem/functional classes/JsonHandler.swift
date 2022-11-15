//
//  jsonHandler.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 09/11/22.
//

import Foundation

class JsonHandler
{
      
    static let patientFile = getFilePathAsUrl(folderName: "dataFiles", fileName: "patientData.json")
    static let doctorFile = getFilePathAsUrl(folderName: "dataFiles", fileName: "doctor.json")
    static let medicineFile = getFilePathAsUrl(folderName:"dataFiles", fileName: "medicine.json")
   
   
    static  func getFilePathAsUrl( folderName:String, fileName:String)->URL {
        
        var currentFileDir = URL(fileURLWithPath: #filePath)
       
        while currentFileDir.lastPathComponent != "hospitalManagementSystem" {
            
            currentFileDir = currentFileDir.deletingLastPathComponent()
        }
        
        if folderName.isEmpty {
            
            return currentFileDir.appendingPathComponent("/\(fileName)")
        }
            return  currentFileDir.appendingPathComponent("/\(folderName)/\(fileName)")
         
     }
   
    static func addToJson(){
        print("writing data")
        do {
            let encoder = JSONEncoder()
            let dataOfPatients = try encoder.encode(DataBase.sharedDb.getPatientDictonary())
            let dataOfDoctors = try encoder.encode(DataBase.sharedDb.getDoctorDictonary())
            let dataOfMedicine = try encoder.encode(Pharamacy.sharedPharmacyObject.getMedicineList())
            
            try dataOfPatients.write(to: patientFile)
            try dataOfDoctors.write(to: doctorFile)
            try dataOfMedicine.write(to: medicineFile)
        }
        catch {
            print(error)
        }
    }
    
    static func initalizeDatabase()    {
        do
        {
//            print(JsonHandler.getFilePathAsUrl(folderName: "dataFiles", fileName: "patientData"))
            let decoder = JSONDecoder()
            guard let patientData = try String(contentsOf: patientFile).data(using: .utf8) else {
               
                fatalError("unable to covert the patient file data to string")
            }
            guard let doctorData = try String(contentsOf: doctorFile).data(using: .utf8) else{
               
                fatalError("unable to convert doctor file data to string")
            }
            
            let doctorDict = try decoder.decode([Int:Doctor].self, from: doctorData)
            let patientDict = try decoder.decode([Int:Patient].self, from: patientData)
            
            DataBase.sharedDb.initalizeDatabase(patientDict, doctorDict)
            
          
            //initalizing pharmacy data in Pharmacy
            guard let medicineData = try String(contentsOf: medicineFile).data(using: .utf8) else{
                fatalError("unable to convert medicine file data to string")
            }
            let medicineDict = try decoder.decode([Int:Medicine].self, from: medicineData)
           
            Pharamacy.sharedPharmacyObject.initalizeMedicineList(medicineDict)
    
        } catch {
            print(error)
        }
        
    }
}
