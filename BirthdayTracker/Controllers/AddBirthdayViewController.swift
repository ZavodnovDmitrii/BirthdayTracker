
import UIKit
import CoreData
import UserNotifications

protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday: [Birthday])
}

class AddBirthdayViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    
    var delegate: AddBirthdayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navVC = navigationController
        navVC?.navigationBar.backgroundColor = .systemBlue
        
        birthdatePicker.maximumDate = Date()
        
        let imageView = SettingsCustomView.shared.customImageFor
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
    
    @IBAction func saveTappedAction(_ sender: Any) {
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthdate = birthdatePicker.date
        
        //MARK: - Save data to the database and transfer data to BirthdayTableViewController.
        DataBase.saveDataToTheDataBase(firstName: firstName, lastName: lastName, birthdate: birthdate) { (birthdays) in
            self.delegate?.addBirthdayViewController(self, didAddBirthday: birthdays)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTappedAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deinit - AddBirthdayViewController")
    }
}

