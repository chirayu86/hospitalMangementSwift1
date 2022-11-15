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
                  2.see all medicines
                  3.check if patient bill is paid
                  4.main menu
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
             seeAllMedicine,
             checkBillStatus,
             mainMenu
    }
    
    static func mainMenu()
    {
       do
       {
           
            Printer.printMessage(.mainMenuMessage)
            print("enter your choice or press 6 to exit")
            let choice = try Validator.integerValidator(readLine(), 7)
            if choice == 6 {
                return
            }
            Printer.printMessage(.loginMenuMessage)
       
            switch LoginMenucases(rawValue: choice) {
            case .adminLogin:
               
                let admin = try Validator.loginValidator(DataBase.sharedDb.getAdminDictonary())
                adminMenu(admin: admin )
          
            case .doctorLogin:
               
                let doctor = try Validator.loginValidator(DataBase.sharedDb.getDoctorDictonary())
                doctorMenu(doctor: doctor )
          
            case .patientLogin:
                
                let patient = try Validator.loginValidator(DataBase.sharedDb.getPatientDictonary())
                patientMenu(patient: patient)
         
            case .recptionistLogin:
                
                let reciptonist = try Validator.loginValidator( DataBase.sharedDb.getReciptonistDictonary())
                reciptionistMenu(reciptonist)
        
            case .pharmacistLogin:
                
                let pharmacist = try Validator.loginValidator(DataBase.sharedDb.getPharamcistDictonary())
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
        do
        {
            Printer.printUserInfo(admin)
            Printer.printMessage(.adminMenuMessage)
            let choice =  try Validator.integerValidator(readLine(), 5)
            switch AdminMenuCases(rawValue: choice) {
                
            case .listAllDoctors:
                
                Printer.printUserList(DataBase.sharedDb.getDoctorDictonary())
                adminMenu(admin: admin)
                
            case .addNewDoctor:
                
                let doctor = try ObjectFactory.createDoctor()
                DataBase.sharedDb.storeDoctorToDataBase(doctor)
                print("added successfully")
                adminMenu(admin: admin)
                
            case .removeDoctor:
                
                print("enter doctor value to remove")
                let doctorId =  try Validator.integerValidator(readLine())
                DataBase.sharedDb.removeDoctorFromDatabase(doctorId)
                print("doctor removed")
                adminMenu(admin: admin)
                
            case .mainMenu:
                
                mainMenu()
                
            default:
                adminMenu(admin: admin)
            }
        }catch{
            print(error)
            adminMenu(admin: admin)
        }
    }
    
    
    private static func doctorMenu(doctor:Doctor)
    {
        
        do
        {
            Printer.printUserInfo(doctor)
            Printer.printMessage(.doctorMenuMessage)
            let choice = try Validator.integerValidator(readLine(), 6)
            
            switch DoctorMenuCases(rawValue: choice) {
                
            case .listAllPatient:
                
                Printer.printUserList(DataBase.sharedDb.getPatientDictonary())
                
                doctorMenu(doctor: doctor)
                
            case .prescribePatient:
               
                print("enter the id of patient u want to precribe")
                let pId = try Validator.integerValidator(readLine())
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
                let patientId = try Validator.integerValidator(readLine())
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
    
    
    
    private static func patientMenu(patient:Patient) {
        do
        {
            Printer.printUserInfo(patient)
            Printer.printMessage(.patientMenuMessage)
            let choice =  try Validator.integerValidator(readLine(), 4)
            switch PatientMenuCases(rawValue: choice) {
            case .seeOwnPrescription:
                
                if patient.prescriptions.isEmpty == false {
                    for prescriptions in patient.prescriptions {
                        
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
      do
      {
        func getBill()throws->Bill
        {
            print("enter patient id for bill")
            let id = try Validator.integerValidator(readLine())
            guard let bill = DataBase.sharedDb.getBill(id) else{
              
                throw ValidationError.noAssociatedValueFound
            }
            return bill
        }
        
        
            Printer.printUserInfo(reciptonist)
            Printer.printMessage(.reciptonistMenuMessage)
            let choice =  try Validator.integerValidator(readLine(), 7)
            
            switch ReciptonistMenuCases(rawValue: choice) {
                
            case .addPatient:
              
                let patient = try ObjectFactory.createPatient()
                DataBase.sharedDb.storePatientToDatabase(patient)
                reciptionistMenu(reciptonist)
           
            
            case .generateBill:
            
                print("enter the patient Id to generate bill for")
                let pid = try Validator.integerValidator(readLine())
                guard let patient = DataBase.sharedDb.getPatientFromDatabase(userId: pid) else {
                    
                    throw ValidationError.invalidId
                    
                }
                print("enter bill details")
                let details = try Validator.emptyStringValidator(readLine())
                if  let unpaidBill = DataBase.sharedDb.getBill(patient.id) {
                    if unpaidBill.amount>0{
                        print("unpaid bill pay this first")
                        Printer.printBill(unpaidBill)
                        reciptionistMenu(reciptonist)
                    } else{
                        print("no old due generating new bill")
                    }
                }
                let bill = reciptonist.generateBill(pat: patient,  details: details)
                print("bill generated successfully")
                DataBase.sharedDb.storeBillToDatabase(bill)
                
                reciptionistMenu(reciptonist)
         
            case .removePatient:
             
                print("enter patient id to remove")
                let patientId = try Validator.integerValidator(readLine())
                DataBase.sharedDb.removePatientFromDataBase(patientId)
               
                reciptionistMenu(reciptonist)
          
            case .updateBill:
                   
                    let bill = try getBill()
                    Printer.printBill(bill)
                    print("enter the amount paid by the patient")
                    let amount =  try Validator.integerValidator(readLine())
                    let message = reciptonist.updateBill(amount, bill)
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
        do
        {
            Printer.printUserInfo(pharmacist)
            Printer.printMessage(.pharmacistMenuMessage)
            let choice = try Validator.integerValidator(readLine(),4)
            switch PharmacistMenuCases(rawValue: choice) {
            case .addMedicine:
                let medicine =  try ObjectFactory.createMedicineObject()
                pharmacist.addMedicine(medicine)
                
                pharmacistMenu(pharmacist: pharmacist)
                
            case .seeAllMedicine:
                let availableMedicineList = Pharamacy.sharedPharmacyObject.getMedicineList()
                for medicine in availableMedicineList.values
                {
                    Printer.printMedicine(medicine)
                }
                
                pharmacistMenu(pharmacist: pharmacist)
            
            case .checkBillStatus:
                print("enter patient id")
                let id  =  try Validator.integerValidator(readLine())
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
        }catch{
            print(error)
            pharmacistMenu(pharmacist: pharmacist) }
        }
        
    }



