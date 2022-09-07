//
//  AddTaskSettingsModel.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation

enum AddTaskTitleComment: String {
    case minLength = "Task title should contain at least 1 charatcer"
}

enum AddTaskTargetComment: String {
    case empty = "You cannot leave this area blank"
}

enum AddTaskCostComment: String {
    case empty = "You cannot leave this area blank"
    case notNumber = "Please enter a valid number"
}

class AddTaskSettingsModel {
    
    // title
    var titleMinLength = 1
    
    
    func isTitleCorrect(title: String) -> CorrectnessComment {
        // min length - not met
        if title.count < self.titleMinLength {
            return CorrectnessComment(isCorrect: false, note: AddTaskTitleComment.minLength.rawValue)
        }
        // all good
        return CorrectnessComment(isCorrect: true, note: "")
    }
    
    func isTargetCorrect(target: String) -> CorrectnessComment {
        // empty string
        if target.count == 0 {
            return CorrectnessComment(isCorrect: false, note: AddTaskTargetComment.empty.rawValue)
        }
        // all good
        return CorrectnessComment(isCorrect: true, note: "")
    }
    
    func isCostCorrect(countCost: String) -> CorrectnessComment {
        // empty string
        if countCost.count == 0 {
            return CorrectnessComment(isCorrect: false, note: AddTaskCostComment.empty.rawValue)
        }
        
        // not a number
        let number = Double(countCost.replacingOccurrences(of: ",", with: "."))
        if number == nil {
            return CorrectnessComment(isCorrect: false, note: AddTaskCostComment.notNumber.rawValue)
        }
        
        // all good
        return CorrectnessComment(isCorrect: true, note: "")
    }
}
