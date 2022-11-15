//
//  printing_module.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 14/10/22.
//

import Foundation

class Printer
{
  
    
    static func printDottedLine(_ char: Character)
    {
        for _ in 0..<100 {
            print(char,terminator: "")
        }
        print()
    }
    
    
    static func printMessage(_ message :MenuController.Message)
    {
        printDottedLine("-")
        print(message.rawValue)
        print("type ~cancel to cancel ongoing operation")
        printDottedLine("-")
        
       
    }
    
    static func printUserInfo(_ user:User)
    {
        let mytime = Date()
        let format = DateFormatter()
        format.timeStyle = .medium
        format.dateStyle = .medium
        
        print("""
             
             
             
              ----------------------------------
              hello \(user.name)  id:\(user.id)
              ----------------------------------
              \(format.string(from: mytime))
             -----------------------------------
             """)
    }

     
    static func printPrescription(_ p :Prescription)
    {
        printDottedLine("=")
        print("This is a prescription for \(p.prescriptionFor)")
        print("----------------")
        print("signed by:-----\(p.prescribingDoctor)")
        printDottedLine("-")
        print("------Test List-----")
        p.testList.forEach{
            test in Printer.printTest(test)
        }
        print("---Medicine list---")
        p.medicinesList.forEach{
            medicine in Printer.printMedicine(medicine)
        }
        print("----note----")
        print(p.noteFromDoctor)
        
        printDottedLine("=")
    }
    
  
    // function to print medicine
    static func printMedicine(_ medicine: Medicine)
    {
        
        print("""
              -----------------------------------
              medicine id is : \(medicine.id)
              name of medicine is :\(medicine.name)
              dosage of medicine is :\(medicine.dosage)
              cost of medicine is : \(medicine.cost)
              ------------------------------------
              """
              )
    }
    
    //function to print test
    static func printTest(_ test:Test)
    {
        print("""
             -------------------------
              test id:   \(test.id)
              test name:  \(test.name)
              test cost:  \(test.cost)
             -------------------------
             """
              )
      
    }
    
 
    //function to printBill
    static func printBill(_ bill: Bill)
    {
        print(
              """
              ----------------------------------------------
               bill for Patient \(bill.nameOnBill)
               bill id -- \(bill.id)
               ---------------------------------------------
               bill amount-- \(bill.amount)
               bill details--\(bill.details)
              ----------------------------------------------
              """
              )
        
    }
   
    
    static func printUserList(_ patientDict:[Int:Patient]) {
        print("""
              --patient details--
              --------------------------------------------
              age         id         name         inDate
              --------------------------------------------
              """
              )
        for values in patientDict.values.sorted(by: {$0.id<$1.id}) {
            print(values.age,values.id,values.name,values.inDate,separator: "         ")
        }
    }
  
    
    //overloading for doctor priniting
    static func printUserList(_ doctorDict:[Int:Doctor]) {
        print("""
              "--Doctor--details--
              ---------------------
              id  name        Dept
              ---------------------
              """)
        for values in doctorDict.values.sorted(by: {$0.id<$1.id}) {
            print(values.id,values.name.padding(toLength: 10, withPad: " ", startingAt: 0),values.department.padding(toLength: 10, withPad: " ", startingAt: 0))
        }
    }
    
}
