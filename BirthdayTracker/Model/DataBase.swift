
import UIKit
import CoreData

private var context: NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    return context
}

private var fetchRequest: NSFetchRequest<Birthday> {
    let fetchRequest = Birthday.fetchRequest() as NSFetchRequest<Birthday>
    let sortDescriptorOne = NSSortDescriptor(key: "lastName", ascending: true)
    let sortDescriptorTwo = NSSortDescriptor(key: "firstName", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptorOne, sortDescriptorTwo]
    return fetchRequest
}

class DataBase {
    
    //MARK: - Get data from the database.
    static var birthdays: [Birthday] {
        var  birthdays = [Birthday]()
        do {
            birthdays = try context.fetch(fetchRequest)
        } catch let error {
            print("An error occurred while requesting: - \(error)")
        }
        return birthdays
    }
    
    //MARK: - Save the received data to the database.
    class func saveDataToTheDataBase(firstName: String, lastName: String, birthdate: Date, comletionBlock: @escaping ([Birthday]) -> ()) {
        
        let newBirthday = Birthday(context: context)
        newBirthday.firstName = firstName
        newBirthday.lastName = lastName
        newBirthday.birthdate = birthdate
        newBirthday.birthdateId = UUID().uuidString
        
        if let uniqueId = newBirthday.birthdateId {
            print("birthdayId: - \(uniqueId)")
        }
        
        do {
            try context.save()
            BirthdayAlerts.messegeBirthday(firstName: firstName, lastName: lastName, birthDate: birthdate, newBirthday: newBirthday)
            //We transfer data to notify birthdays
        } catch let error {
            print("Not saved context.Error: - \(error)")
        }
        comletionBlock(birthdays)
        //We transfer data to AddBirthdayViewController
    }
}

