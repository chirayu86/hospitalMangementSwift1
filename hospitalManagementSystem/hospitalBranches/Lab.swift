//
//  Lab.swift
//  hospitalManagementSystem
//
//  Created by chirayu-pt6280 on 02/11/22.
//

import Foundation

class Lab
{
    static let sharedLabObject = Lab()
    private var testList: [Int:Test] = [101:Test(id: 101, name: "hemoglobin", cost: 1000),
                                        102:Test(id: 102, name: "urine test", cost: 200),
                                        103:Test(id: 103, name: "mri", cost: 5000)]
    private init(){
        
    }
    
    func getTestList()->[Int:Test]{
        return testList
    }
}


struct Test:Codable
{
    let id:Int
    let name:String
    let cost:Int
}
