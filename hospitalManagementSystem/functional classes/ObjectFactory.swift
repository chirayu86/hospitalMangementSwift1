//
//  Factory.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 10/11/22.
//

import Foundation

class ObjectFactory
{
    
    enum UserType{
       
        case doctor,
             patient
    }
    
    //trying out factory method for creating user from a single function
    static func createUser(_ type: UserType)throws->User
    {
        switch type {
            
        case .doctor:
            print("enter doctor name")
            let name = try Validator.nameValidator(readLine())
            print("enter user Id")
            let id = try Validator.integerValidator(readLine())
            print("set password")
            let password = try Validator.emptyStringValidator(readLine())
            print("enter doctor Department")
            let department = try Validator.emptyStringValidator(readLine())
            return Doctor(department: department, name: name, id: id, Passwordhash: password.hash)
            
        case.patient:
            print("enter patient name")
            let name = try Validator.nameValidator(readLine())
            print("enter user Id")
            let id = try Validator.integerValidator(readLine())
            print("set password")
            let password = try Validator.emptyStringValidator(readLine())
            print("enter patient in Date")
            let inDate = try Validator.emptyStringValidator(readLine())
            print("enter the age of the patient")
            let age = try Validator.integerValidator(readLine())
            return Patient(age: age, date: inDate, name: name, id: id, passwordHash: password.hash)
            
        }
    }
    
    
    static func createDoctor()throws->Doctor {
        
        print("enter doctor name")
        let name = try Validator.nameValidator(readLine())
        print("enter user Id")
        let id = try Validator.integerValidator(readLine())
        print("set password")
        let password = try Validator.emptyStringValidator(readLine())
        print("enter doctor Department")
        let department = try Validator.emptyStringValidator(readLine())
        return Doctor(department: department, name: name, id: id, Passwordhash: password.hash)
       
       
}
        
    
        static func createPatient()throws->Patient {
            
                print("enter patient name")
                let name = try Validator.nameValidator(readLine())
                print("enter user Id")
                let id = try Validator.integerValidator(readLine())
                print("set password")
                let password = try Validator.emptyStringValidator(readLine())
                print("enter patient in Date")
                let inDate = try Validator.emptyStringValidator(readLine())
                print("enter the age of the patient")
                let age = try Validator.integerValidator(readLine())
                return Patient(age: age, date: inDate, name: name, id: id, passwordHash: password.hash)
            }
                

    
    static func createPrescription(doctor:Doctor,patient:Patient)throws->Prescription {
      
        var prescribedTestList: [Test] = []
        var prescribedMedicineList: [Medicine] = []
       
        let availableTestList = Lab.sharedLabObject.getTestList()
        print("-----available test List---------")
        for test in availableTestList.values {
            
            Printer.printTest(test)
        }
        print("enter the no of tests you want to prescribe(maximum 4)")
        let numberOfTests = try Validator.integerValidator(readLine(), 5)
        for _ in 0..<numberOfTests {
            print("enter the id of test")
            let test = try Validator.integerValidator(readLine())
            guard let test = availableTestList[test] else {
                
                print("invalid id")
                return try createPrescription(doctor: doctor, patient: patient)
                
            }
            prescribedTestList.append(test)
        }
        print("available medicine list")
        let availableMedicineList = Pharamacy.sharedPharmacyObject.getMedicineList()
        for medicine in availableMedicineList.values {
        
            Printer.printMedicine(medicine)
        }
        print("enter the number of medicines")
        let numberOfmedicine = try Validator.integerValidator(readLine(), 5)
        for _ in 0..<numberOfmedicine {
            print("enter id of medicine")
            let medicineId =  try Validator.integerValidator(readLine())
            guard let medicine = availableMedicineList[medicineId] else {
                
                print("invalid id")
               return try createPrescription(doctor: doctor, patient: patient)
                
            }
            prescribedMedicineList.append(medicine)
        }
        print("write a note")
        let note = try Validator.emptyStringValidator(readLine())
        
        return Prescription(prescribingDoctor: doctor.name, prescriptionFor: patient.name, testList: prescribedTestList, medicinesList: prescribedMedicineList, noteFromDoctor: note, prescriptionId: patient.id)
   
    }
    
    
    static func createMedicineObject()throws->Medicine {
        
            print("enter the name of medicine")
            let name = try Validator.nameValidator(readLine())
            print("enter medicine id")
            let id = try Validator.integerValidator(readLine())
            print("enter prescribed dose")
            let dose = try Validator.emptyStringValidator(readLine())
            print("enter cost of medicine")
            let cost = try Validator.integerValidator(readLine())
            return Medicine(id: id, name: name, dosage: dose, cost: cost)
        
    }
    
}
