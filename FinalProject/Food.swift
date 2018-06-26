//
//  Food.swift
//  FinalProject
//
//  Created by User01 on 2018/6/26.
//  Copyright © 2018年 isr10132. All rights reserved.
//

import Foundation

struct Food: Codable {
    var store: String
    var address: String
    var food: String
    var price: Int
    var description: String
    var star: Int
    var photo: String
    var latitude: String
    var longitude: String
    
    static func readLoversFromFile() -> [Food]? {
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "foods"), let foods = try? propertyDecoder.decode([Food].self, from: data) {
            return foods
        } else {
            return nil
        }
    }
    
    static func saveToFile(foods: [Food]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(foods) {
            UserDefaults.standard.set(data, forKey: "foods")
        }
    }
}
