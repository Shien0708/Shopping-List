//
//  ItemTableViewController.swift
//  Shopping List
//
//  Created by Shien on 2022/5/24.
//

import UIKit

class ItemTableViewController: UITableViewController, UINavigationControllerDelegate {
    var item: Item?
    var selectPhoto = false
    
    @IBOutlet weak var itemStateSwith: UISwitch!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var itemUnitTextField: UITextField!
    @IBOutlet weak var itemDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemDetailTextView.layer.borderWidth = 1
        itemDetailTextView.layer.opacity = 0.8
        updateUI()
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
    }
    
    func updateUI() {
        if let item = item {
            itemNameTextField.text = item.name
            itemStateSwith.isOn = item.isBought
            if let imageName = item.imageName {
                let imageUrl = Item.documentsDirectory.appendingPathComponent(imageName).appendingPathExtension("jpg")
                let image = UIImage(contentsOfFile: imageUrl.path)
                itemImageView.image = image
            }
            //
            if item.price != nil {
                itemPriceTextField.text = String(item.price!)
            }
            itemDetailTextView.text = item.description ?? ""
            itemUnitTextField.text = item.unit ?? ""
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let source = segue.source as? ItemTableViewController {
            let name = source.itemNameTextField.text!
            let state = source.itemStateSwith.isOn
            let detail = source.itemDetailTextView.text ?? ""
            let unit = source.itemUnitTextField.text ?? ""
            var imageName: String?
            let price = source.itemPriceTextField.text ?? ""
            
            if selectPhoto {
                if let item = item {
                    imageName = item.imageName
                }
                if imageName == nil {
                    imageName = UUID().uuidString
                }
                let imageData = itemImageView.image?.jpegData(compressionQuality: 0.9)
                let imageUrl = Item.documentsDirectory.appendingPathComponent(imageName!).appendingPathExtension("jpg")
                try? imageData?.write(to: imageUrl)
                selectPhoto = false
            } else {
                if let item = item {
                    imageName = item.imageName
                }
            }
            
            item = Item(name: name, imageName: imageName, price: Double(price), description: detail, isBought: state, unit: unit)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if itemNameTextField.text?.isEmpty == true {
            let controller = UIAlertController(title: "請輸入物品名稱", message: nil, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            present(controller, animated: true)
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo", style: .default, handler: { action in
            controller.sourceType = .photoLibrary
            self.present(controller, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            controller.sourceType = .camera
            self.present(controller, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        
    }
    
}


extension ItemTableViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        itemImageView.image = image
        selectPhoto = true
        dismiss(animated: true)
    }
}
