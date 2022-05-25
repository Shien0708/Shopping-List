//
//  Topic.swift
//  Shopping List
//
//  Created by Shien on 2022/5/25.
//

import Foundation

struct Topic: Codable {
    var name:String
    var detail: String?
    var dateString: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveTopic(topics: [Topic]) {
       let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(topics) {
            let url = Self.documentsDirectory.appendingPathComponent("topic")
            try? data.write(to: url)
        }
    }
    
    static func loadTopic() -> [Topic]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Self.documentsDirectory.appendingPathComponent("topic")
        if let data = try? Data(contentsOf: url), let topics = try? propertyDecoder.decode([Self].self, from: data) {
            return topics
        } else {
            return nil
        }
    }
}
