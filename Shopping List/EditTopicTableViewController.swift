//
//  EditTopicTableViewController.swift
//  Shopping List
//
//  Created by Shien on 2022/5/25.
//

import UIKit

class EditTopicTableViewController: UITableViewController {
    var topic: Topic?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var topicDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enableDate(_ sender: UISwitch) {
        if sender.isOn {
            topicDatePicker.isEnabled = true
        } else {
            topicDatePicker.isEnabled = false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if nameTextField.text?.isEmpty == true {
            let controller = UIAlertController(title: "請輸入主題名稱", message: nil, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            present(controller, animated: true)
            return false
        } else {
            return true
        }
    }
    
    func formDateString(date: Date) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name = nameTextField.text!
        let detail = detailTextView.text ?? ""
        let dateString = formDateString(date: topicDatePicker.date) ?? ""
        
        topic = Topic(name: name, detail: detail, dateString: dateString)
    }
 
    // MARK: - Table view data source

   
   
}
