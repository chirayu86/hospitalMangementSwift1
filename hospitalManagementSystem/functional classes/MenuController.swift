//
//  MenuModule.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 14/10/22.
//

import Foundation



class MenuController
{
    enum Message:String{
       
        case mainMenuMessage = """
                  press 1 for:Admin login
                  press 2 for:Doctor login
                  press 3 for:Patient login
                  press 4 for:Reciptonist login
                  press 5 for:Pharamacist login
                  """
        case loginMenuMessage = "enter your user id and password"
        
        case adminMenuMessage =
                  """
                  1.List all doctors
                  2.add new doctor
                  3.remove doctor
                  4.main menu
                  """
        case doctorMenuMessage = """
                  1.list all patients
                  2.prescribe a patient
                  3.return patients i have prescribed
                  4.get prescription
                  5.main menu
                """
        case patientMenuMessage = """
                  1.see prescription
                  2.check bill amount
                  3.main menu
                  """
        case reciptonistMenuMessage = """
                   1.add patient
                   2.generate bill
                   3.remove patient
                   4.update bill amount
                   5.see bill amount for patient
                   6.main menu
                """
        case pharmacistMenuMessage = """
                  1.add Medicine
                  2.check if patient bill is paid
                  3.main menu
               """
        case billIsPaid = "bill is paid you can provide the prescription to the patient "
        
        case billNotPaid = "bill must be paid before getting the medicine"
        
        case billNotFound = "bill not Found"
     }
  
    enum LoginMenucases:Int{
        case adminLogin = 1,
             doctorLogin,
             patientLogin,
             recptionistLogin,
             pharmacistLogin,
             saveAndExit
    }
    enum DoctorMenuCases:Int{
        case listAllPatient = 1,
             prescribePatient,
             listPatientsAlreadyPrescribed,
             getPrescriptionForPatient,
             mainMenu
    }
    enum AdminMenuCases:Int{
        case listAllDoctors = 1,
             addNewDoctor,
             removeDoctor,
             mainMenu
    }
    enum PatientMenuCases:Int{
        case seeOwnPrescription = 1,
             checkBillAmount,
             mainMenu
    }
    enum ReciptonistMenuCases:Int{
        case addPatient = 1,
             generateBill,
             removePatient,
             updateBill,
             seeBillForPatient,
             mainMenu
    }
    enum PharmacistMenuCases:Int{
        case addMedicine = 1,
             checkBillStatus,
             mainMenu
    }
    
    static func mainMenu()
    {
       
            Printer.printMessage(.mainMenuMessage)
            print("enter your choice or press 6 to exit")
            let choice = Validator.intTypeValidator(readLine(), 7)
            if choice == 6 {
                return
            }
            Printer.printMessage(.loginMenuMessage)
        do
        {
            switch LoginMenucases(rawValue: choice) {
            case .adminLogin:
               
                let admin = try Validator.loginValidator(DataBase.sharedDb.getAdminList())
                adminMenu(admin: admin )
          
            case .doctorLogin:
               
                let doctor = try Validator.loginValidator(DataBase.sharedDb.getDoctorList())
                doctorMenu(doctor: doctor )
          
            case .patientLogin:
                
                let patient = try Validator.loginValidator(DataBase.sharedDb.getPatientList())
                patientMenu(patient: patient)
         
            case .recptionistLogin:
                
                let reciptonist = try Validator.loginValidator( DataBase.sharedDb.getReciptonistList())
                reciptionistMenu(reciptonist)
        
            case .pharmacistLogin:
                
                let pharmacist = try Validator.loginValidator(DataBase.sharedDb.getPharamcistList())
                pharmacistMenu(pharmacist: pharmacist)
          
            case.saveAndExit:
                print("exiting")
           
            default :
                mainMenu()
                
            }
            
        } catch {
            print(error)
            mainMenu()
        }
    }
    
    
    private static func adminMenu(admin:Admin)
    {
            Printer.printMessage(.adminMenuMessage)
            let choice =   Validator.intTypeValidator(readLine(), 5)
            switch AdminMenuCases(rawValue: choice) {
                
            case .listAllDoctors:
               
                Printer.printUserList(DataBase.sharedDb.getDoctorList())
                adminMenu(admin: admin)
         
            case .addNewDoctor:
               
                let doctor = ObjectFactory.createUser()
                DataBase.sharedDb.storeDoctorToDataBase(doctor)
                print("added successfully")
                adminMenu(admin: admin)
         
            case .removeDoctor:
               
                print("enter doctor value to remove")
                let doctorId =  Validator.intTypeValidator(readLine())
                DataBase.sharedDb.removeDoctorFromDatabase(doctorId)
                print("doctor removed")
                adminMenu(admin: admin)
          
            case .mainMenu:
                
                mainMenu()
          
            default:
                adminMenu(admin: admin)
            }
    }
    
    
    private static func doctorMenu(doctor:Doctor)
    {
        
        do
        {
            Printer.printMessage(.doctorMenuMessage)
            let choice =  Validator.intTypeValidator(readLine(), 6)
            
            switch DoctorMenuCases(rawValue: choice) {
                
            case .listAllPatient:
                
                Printer.printUserList(DataBase.sharedDb.getPatientList())
                
                doctorMenu(doctor: doctor)
                
            case .prescribePatient:
               
                print("enter the id of patient u want to precribe")
                let pId =  Validator.intTypeValidator(readLine())
                //validating patients exits in database before doing operation
                guard let patient = DataBase.sharedDb.getPatientFromDatabase(userId: pId)  else {
                    throw ValidationError.noAssociatedValueFound
                }
                let prescription = try ObjectFactory.createPrescription(doctor: doctor, patient: patient)
                    doctor.prescribePatient(patient,prescription: prescription)
            
                doctorMenu(doctor: doctor)
                
            case .listPatientsAlreadyPrescribed:
                
                let patientList = doctor.getPatientPreviouslyPrescribed()
                Printer.printUserList(patientList)
                
                doctorMenu(doctor: doctor)
                
            case .getPrescriptionForPatient:
                
                print("enter the id of patient to get prescription for")
                let patientId = Validator.intTypeValidator(readLine())
                guard let temporaryObjectForPatient = doctor.getPatientPreviouslyPrescribed(id: patientId) else {
                   
                    throw ValidationError.noAssociatedValueFound
                }
                for prescriptions in temporaryObjectForPatient.prescriptions {
                  
                    Printer.printPrescription(prescriptions)
            }
                
                    
                
                doctorMenu(doctor: doctor)
                
            case .mainMenu:
                    mainMenu()
            default:
                print("wrong choice")
               
                doctorMenu(doctor: doctor)
                
            }
        }catch{
            print(error)
            doctorMenu(doctor: doctor)
        }
    }
    
    
    
    private static func patientMenu(patient:Patient)
    {
        do
        {
            Printer.printMessage(.patientMenuMessage)
            let choice =   Validator.intTypeValidator(readLine(), 4)
            switch PatientMenuCases(rawValue: choice) {
            case .seeOwnPrescription:
                
                if patient.prescriptions.isEmpty == false {
                    for prescriptions in patient.prescriptions{
                        
                        Printer.printPrescription(prescriptions)
                    }
                }
                else{
                    print("no prescription found")
                }
                
                patientMenu(patient: patient)
           
            case .checkBillAmount:
               
                let bill = DataBase.sharedDb.getBill(patient.id)
                guard let unwarppedBill = bill else {
                    
                    throw ValidationError.noAssociatedValueFound
                }
                Printer.printBill(unwarppedBill)
                
                patientMenu(patient: patient)
           
            case .mainMenu:
               
                mainMenu()
            default:
                patientMenu(patient: patient)
            }
        } catch {
            print(error)
            patientMenu(patient: patient)
        }
    }
    
    
    private static func reciptionistMenu(_ reciptonist: Reciptonist)
    {
     
        func getBill()throws->Bill
        {
            print("enter patient id for bill")
            let id =  Validator.intTypeValidator(readLine())
            guard let bill = DataBase.sharedDb.getBill(id) else{
              
                throw ValidationError.noAssociatedValueFound
            }
            return bill
        }
        
        do
        {
            Printer.printMessage(.reciptonistMenuMessage)
            let choice =  Validator.intTypeValidator(readLine(), 7)
            
            switch ReciptonistMenuCases(rawValue: choice) {
                
            case .addPatient:
              
                let patient = ObjectFactory.createPatient()
                DataBase.sharedDb.storePatientToDatabase(patient)
                reciptionistMenu(reciptonist)
           
            
            case .generateBill:
            
                print("enter the patient Id to generate bill for")
                let pid =  Validator.intTypeValidator(readLine())
                guard let patient = DataBase.sharedDb.getPatientFromDatabase(userId: pid) else {
                    
                    throw ValidationError.invalidId
                    
                }
                print("enter bill details")
                let details = Validator.stringTypeValidator(readLine())
                if  let unpaidBill = DataBase.sharedDb.getBill(patient.id)
                {
                    if unpaidBill.amount>0{
                        print("unpaid bill pay this first")
                        Printer.printBill(unpaidBill)
                        reciptionistMenu(reciptonist)
                    } else{
                        print("no old due generating new bill")
                    }
                }
                let bill = reciptonist.generateBill(pat: patient,  details: details)
                DataBase.sharedDb.storeBillToDatabase(bill)
                
                reciptionistMenu(reciptonist)
         
            case .removePatient:
             
                print("enter patient id to remove")
                let patientId =  Validator.intTypeValidator(readLine())
                DataBase.sharedDb.removePatientFromDataBase(patientId)
               
                reciptionistMenu(reciptonist)
          
            case .updateBill:
                   
                    let bill = try getBill()
                    Printer.printBill(bill)
                    print("enter the amount paid by the patient")
                    let amount =  Validator.intTypeValidator(readLine())
                    let message = reciptonist.acceptBill(amount, bill)
                    print(message)
                
                
                reciptionistMenu(reciptonist)
                
            case .seeBillForPatient:
                    
                    let bill = try getBill()
                    Printer.printBill(bill)
                
                reciptionistMenu(reciptonist)
           
            case .mainMenu:
                mainMenu()
            
            default :
                print("wrong choice")
                reciptionistMenu(reciptonist)
            }
        } catch{
            print(error)
            reciptionistMenu(reciptonist)
            
            }
    }
    
    
    private static func pharmacistMenu(pharmacist: Pharmacist)
    {
       
            Printer.printMessage(.pharmacistMenuMessage)
            let choice =  Validator.intTypeValidator(readLine(),4)
            switch PharmacistMenuCases(rawValue: choice) {
            case .addMedicine:
                let medicine =  ObjectFactory.createMedicineObject()
                pharmacist.addMedicine(medicine)
                pharmacistMenu(pharmacist: pharmacist)
            
            case .checkBillStatus:
                print("enter patient id")
                let id  =  Validator.intTypeValidator(readLine())
                if let bill = DataBase.sharedDb.getBill(id){
                    if bill.amount == 0 {
                        Printer.printMessage(.billIsPaid)
                    } else {
                        Printer.printMessage(.billNotPaid)
                    }
                } else {
                    Printer.printMessage(Message.billNotFound)
                 }
                
                pharmacistMenu(pharmacist: pharmacist)
           
            case .mainMenu:
                   mainMenu()
            default:
                pharmacistMenu(pharmacist: pharmacist)
            }
        }
        
    }



