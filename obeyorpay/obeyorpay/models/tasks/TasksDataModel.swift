//
//  TasksData.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation

class TasksDataModel: ObservableObject {
    
    @Published var tasks = [
        TaskTypes.personal: [
            TaskDataModel(title: "personal task number 1", count: 5, goal: 10),
            TaskDataModel(title: "personal task number 2", count: 4, goal: 6)
        ],
        TaskTypes.joint: [
            TaskDataModel(title: "joint task number 1", count: 5, goal: 10),
            TaskDataModel(title: "joint task number 2", count: 4, goal: 6)
        ],
        TaskTypes.shared: [
            TaskDataModel(title: "shared task number 1", count: 5, goal: 10),
            TaskDataModel(title: "shared task number 2", count: 4, goal: 6)
        ]
    ]
}
