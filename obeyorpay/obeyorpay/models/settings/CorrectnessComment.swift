//
//  CorrectnessComment.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import Foundation

struct CorrectnessComment {
    var isCorrect: Bool
    var note: String?
    
    init(isCorrect: Bool, note: String?) {
        self.isCorrect = isCorrect
        self.note = note
    }
}
