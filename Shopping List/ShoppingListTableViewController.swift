//
//  ShoppingListTableViewController.swift
//  Shopping List
//
//  Created by Shien on 2022/5/24.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    var selectPhoto = false
    
    var items = [Item]() {
        didSet {
            Item.saveToFile(items: items)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = Item.readItemsFromFile() {
            self.items = items
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath) as? ShoppingListTableViewCell else { return ShoppingListTableViewCell() }
        
        
        if !items.isEmpty {
            cell.itemNameLabel.text = items[indexPath.row].name
            cell.itemPriceLabel.text = "$ "+String(items[indexPath.row].price ?? 0)
            cell.itemUnitLabel.text = items[indexPath.row].unit ?? ""
            if items[indexPath.row].isBought {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            if let imageName = items[indexPath.row].imageName {
                let imageUrl = Item.documentsDirectory.appendingPathComponent(imageName).appendingPathExtension("jpg")
                let image = UIImage(contentsOfFile: imageUrl.path)
                cell.itemImageView.image = image
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ItemTableViewController {
            if let row = tableView.indexPathForSelectedRow?.row {
                controller.item = items[row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.reloadData()
    }
    
     
    @IBAction func save(_ segue: UIStoryboardSegue) {
        if let sourceController = segue.source as? ItemTableViewController, let item = sourceController.item {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                items[indexPath.row] = item
            } else {
                items.insert(item, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            tableView.reloadData()
        }
    }
}
