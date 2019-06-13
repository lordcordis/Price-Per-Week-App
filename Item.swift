//
//  Item.swift
//  PricePerWeek
//
//  Created by Роман Коренев on 13/06/2019.
//  Copyright © 2019 Роман Коренев. All rights reserved.
//

import Foundation


struct Item: Codable {
    var name: String
    var price: Int
    var date: Date
    
    var dateAsString: String {
        get {
            let format = DateFormatter()
            format.dateStyle = .medium
            let result = format.string(from: self.date)
            return result
            
        }
    }
    
    var pricePerWeek: Int {
        get {
            var interval = DateInterval()
            interval.start = date
            interval.end = Date()
            let secondsSince = interval.duration.rounded()
            let minutes = secondsSince / 60
            let hours = minutes / 60
            let days = hours / 24
            let weeks = days/7
            let weeksRounded = Int(weeks.rounded())

            let pricePerWeek = price/weeksRounded
            return pricePerWeek
        }
    }
    
}
