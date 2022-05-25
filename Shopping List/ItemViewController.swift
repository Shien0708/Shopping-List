//
//  ItemViewController.swift
//  Shopping List
//
//  Created by Shien on 2022/5/24.
//

import UIKit

class ItemViewController: UIViewController {
    var item: Item?
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var itemNameLabel: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemPriceLabel: UITextField!
    @IBOutlet weak var itemStateSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        if let item = item {
            itemNameLabel.text = item.name
            if let price = item.price {
                itemPriceLabel.text = String(price)
            }
            itemImageView.image = item.image ?? UIImage(systemName: "photo")!
            descriptionTextView.text = item.description ?? ""
            itemStateSwitch.isOn = item.isBought
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name = itemNameLabel.text ?? ""
        let price = Double(itemPriceLabel.text ?? "")
        let description = descriptionTextView.text ?? ""
        let image = itemImageView.image ?? UIImage()
        let bought = itemStateSwitch.isOn
        
        item = Item(name: name, image: image, price: price, description: description, isBought: bought)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if itemNameLabel.text?.isEmpty == true {
            let controller = UIAlertController(title: "Enter item Name!", message: nil, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default))
            present(controller, animated: true)
            return false
        } else {
            return true
        }
    }
   
}
