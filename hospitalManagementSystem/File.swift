//
//  File.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 26/10/22.
//

import Foundation
class jsonHandler
{
    static func addUserToJson()
    {
        var tempPatientArray: [Patient] = []
        var tempDoctorArray: [Doctor] = []
        var tempAdminArray: [Admin] = []
        var tempRecptonistArray: [Reciptonist] = []
        for user in userListDict.values
        {
            if user is Patient
            {
                tempPatientArray.append(user as! Patient)
            }
            if user is Doctor
            {
                tempDoctorArray.append(user as! Doctor)
            }
            if user is Admin
            {
                tempAdminArray.append(user as! Admin)
            }
            if user is Reciptonist
            {
                tempRecptonistArray.append(user as! Reciptonist)
            }
        }
        do
        {
            
            let encoder = JSONEncoder()
            let dataP =  try encoder.encode(tempPatientArray)
            let dataD = try encoder.encode(tempDoctorArray)
            let dataAD = try encoder.encode(tempAdminArray)
            let dataRec = try encoder.encode(tempRecptonistArray)
            let urlToWritePatient = URL(fileURLWithPath:"/Users/chirayu-pt6280/Desktop/demo/hospitalManagementSystem/hospitalManagementSystem/patientData.json")
            let urlToWriteDoctor = URL(fileURLWithPath:"/Users/chirayu-pt6280/Desktop/demo/hospitalManagementSystem/hospitalManagementSystem/doctor.json")
            let urlToWriteAdmin =
               URL(fileURLWithPath:"/Users/chirayu-pt6280/Desktop/demo/hospitalManagementSystem/hospitalManagementSystem/admin.json")
            let urlToWriteRec = URL(fileURLWithPath:"/Users/chirayu-pt6280/Desktop/demo/hospitalManagementSystem/hospitalManagementSystem/reciptonist.json")
            if String(data: dataP,encoding: .utf8) != nil
            {
                do
                {
                    try dataP.write(to: urlToWritePatient)
                }
                catch
                {
                    print(error)
                }
            }
            if String(data: dataD,encoding: .utf8) != nil
            {
                do
                {
                    try dataD.write(to: urlToWriteDoctor)
                }
                catch
                {
                    print(error)
                }
            }
            if String(data: dataAD,encoding: .utf8) != nil
            {
                do
                {
                    try dataAD.write(to: urlToWriteAdmin)
                }
                catch
                {
                    print(error)
                }
            }
            if String(data: dataRec,encoding: .utf8) != nil
            {
                do
                {
                    try dataRec.write(to: urlToWriteRec)
                }
                catch
                {
                    print(error)
                }
            }
            
        }catch
        {
            print(error)
        }
    }

}
