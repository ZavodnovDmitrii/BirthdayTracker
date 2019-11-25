
import UIKit

class BirthdayAlerts {
    
    class func messegeBirthday(firstName: String, lastName: String, birthDate: Date, newBirthday: Birthday) {
        
        //MARK: - Configure the notification's payload.
        let messege = "Сегодня день рождение у \(firstName) \(lastName)!"
        let content = UNMutableNotificationContent()
        content.body = messege
        content.sound = .default
        
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: birthDate)
        dateComponents.hour = 9
        
        //MARK: - Deliver the notification
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        if let identifier = newBirthday.birthdateId {
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
        }
    }
}
