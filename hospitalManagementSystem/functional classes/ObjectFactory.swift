//
//  Factory.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 10/11/22.
//

import Foundation

class ObjectFactory
{
    enum ObjectCreationErrors:Error{
        case invalidUserType
    }
    
    enum Users:String{
        case doctor = "doctor",
             patient = "patient"
    }
    
    
    static func createUser()->Doctor {
        
        print("enter doctor name")
        let name = Validator.stringTypeValidator(readLine())
        print("enter user Id")
        let id = Validator.intTypeValidator(readLine())
        print("set password")
        let password =  Validator.stringTypeValidator(readLine())
        print("enter doctor Department")
        let department = Validator.stringTypeValidator(readLine())
        return Doctor(department: department, name: name, id: id, Passwordhash: password.hash)
       
       
}
        
    
        static func createPatient()->Patient {
            
                print("enter patient name")
                let name = Validator.stringTypeValidator(readLine())
                print("enter user Id")
                let id = Validator.intTypeValidator(readLine())
                print("set password")
                let password =  Validator.stringTypeValidator(readLine())
                print("enter patient in Date")
                let inDate = Validator.stringTypeValidator(readLine())
                print("enter the age of the patient")
                let age = Validator.intTypeValidator(readLine())
                return Patient(age: age, date: inDate, name: name, id: id, passwordHash: password.hash)
            }
                

    
    static func createPrescription(doctor:Doctor,patient:Patient)throws->Prescription {
      
        var testList: [Test] = []
        var medicineList: [Medicine] = []
        let availableTestList = doctor.getAvailableTests()
        print("available test List")
        for (key,value) in availableTestList {
            
            print("----")
            print(key)
            Printer.printTest(value)
        }
        print("enter the no of tests")
        let numberOfTests = Validator.intTypeValidator(readLine(), 5)
        for _ in 0..<numberOfTests {
            print("enter the id of test")
            let test = Validator.intTypeValidator(readLine())
            guard let test = availableTestList[test] else {
                
                throw ValidationError.invalidId
                
            }
            testList.append(test)
        }
        print("available medicine list")
        let availableMedicineList = doctor.getAvailableMedicines()
        for (key,medicine) in availableMedicineList{
            print(key)
            Printer.printMedicine(medicine)
        }
        print("enter the number of medicines")
        let numberOfmedicine = Validator.intTypeValidator(readLine(), 5)
        for _ in 0..<numberOfmedicine {
            print("enter id of medicine")
            let medicineId =  Validator.intTypeValidator(readLine())
            guard let medicine = availableMedicineList[medicineId] else {
                throw ValidationError.invalidId
                
            }
            medicineList.append(medicine)
        }
        print("write a note")
        let note = Validator.stringTypeValidator(readLine())
        
        return Prescription(prescribingDoctor: doctor.name, prescriptionFor: patient.name, testList: testList, medicinesList: medicineList, noteFromDoctor: note, prescriptionId: patient.id)
   
    }
    
    
    static func createMedicineObject()->Medicine {
        
            print("enter the name of medicine")
            let name = Validator.stringTypeValidator(readLine())
            print("enter medicine id")
            let id = Validator.intTypeValidator(readLine())
            print("enter prescribed dose")
            let dose = Validator.stringTypeValidator(readLine())
            print("enter cost of medicine")
            let cost = Validator.intTypeValidator(readLine())
            return Medicine(id: id, name: name, dosage: dose, cost: cost)
        
    }
    
}
