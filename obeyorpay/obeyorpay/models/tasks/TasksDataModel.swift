//
//  TasksData.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import Foundation

class TasksDataModel: ObservableObject {
    
    @Published var tasks: [TaskModel] = []
}
