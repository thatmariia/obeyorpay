//
//  TaskData.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation

struct TaskDataModel: Identifiable, Equatable, Hashable {
    var id = UUID().uuidString
    var title: String
    var count: Int
    var goal: Int
    
    init(title: String, count: Int, goal: Int) {
        self.title = title
        self.count = count
        self.goal = goal
    }
}
