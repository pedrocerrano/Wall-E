//
//  Date+Ext.swift
//  Wall-E
//
//  Created by iMac Pro on 2/25/23.
//

import Foundation

extension Date {
    func asString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: self)
    }
}
