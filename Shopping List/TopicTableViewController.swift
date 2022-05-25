//
//  TopicTableViewController.swift
//  Shopping List
//
//  Created by Shien on 2022/5/25.
//

import UIKit


class TopicTableViewController: UITableViewController {
    
    var topics = [Topic]() {
        didSet {
            Topic.saveTopic(topics: topics)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topics = Topic.loadTopic() ?? [Topic]()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topics.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TopicTableViewCell.self)", for: indexPath) as? TopicTableViewCell else { return TopicTableViewCell() }
        cell.nameLabel.text = topics[indexPath.row].name
        cell.dateLabel.text = topics[indexPath.row].dateString ?? ""
        cell.detailLabel.text = topics[indexPath.row].detail ?? ""
        
        // Configure the cell...
        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        topics.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.reloadData()
    }
    
    @IBAction func buildTopic(_ segue: UIStoryboardSegue) {
        if let source = segue.source as? EditTopicTableViewController {
            topics.insert(source.topic!, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at:[indexPath], with: .automatic)
        }
    }
    

}
