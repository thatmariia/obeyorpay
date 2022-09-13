//
//  DecisionButtonsView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import SwiftUI

struct DecisionButtonsView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    var body: some View {
        VStack {
            Button {
                // accept
            } label: {
                Image(systemName: "checkmark.circle.fill")
            }
            .buttonStyle(DecisionButtonStyle(color: task.color))
            
            Button {
                // reject
            } label: {
                Image(systemName: "x.circle")
            }
            .buttonStyle(DecisionButtonStyle(color: task.color))

        }
    }
    
    private func acceptTask(task: TaskStoreModel) {
        do {
            try taskSettings.acceptTask(task: task, taskType: taskType, signedInUser: signedInUser)
        } catch let err {}
    }
    
    private func rejectTask(task: TaskStoreModel) {
        do {
            try taskSettings.rejectTask(task: task, taskType: taskType, signedInUser: signedInUser)
        } catch let err {}
    }
}

//struct DecisionButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DecisionButtonsView()
//    }
//}
