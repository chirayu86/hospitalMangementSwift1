
import Foundation

class Prescription:Codable
{
    let id: Int
    let prescribingDoctor:String
    let prescriptionFor:String
    let testList: [Test]
    let medicinesList: [Medicine]
    let noteFromDoctor: String
    var billGenerated:Bool = false
    
    
init(prescribingDoctor: String, prescriptionFor: String, testList: [Test], medicinesList:[Medicine],noteFromDoctor:String,prescriptionId:Int) {
        self.prescribingDoctor = prescribingDoctor
        self.prescriptionFor = prescriptionFor
        self.testList = testList
        self.medicinesList = medicinesList
        self.noteFromDoctor = noteFromDoctor
        self.id = prescriptionId
    }
    

}




