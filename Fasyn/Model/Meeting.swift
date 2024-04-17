//
//  Meeting.swift
//  Fasyn
//
//  Created by 김상금 on 4/17/24.
//

import Foundation

struct Meeting: Identifiable {
    var id = UUID()
    var title: String
    var date: Date
    // Add more properties like date, time, etc. if needed
}
