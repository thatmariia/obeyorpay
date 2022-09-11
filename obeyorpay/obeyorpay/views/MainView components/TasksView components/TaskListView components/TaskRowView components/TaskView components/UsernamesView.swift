//
//  UsernamesView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct UsernamesView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    var body: some View {
        HStack(spacing: 0) {
            if taskType != .shared {
                Text("@\(signedInUser.user.username)")
            }
            
            ForEach(jointUsers(), id: \.self) { username in
                Text(" • @\(username)")
            }
        }
        .foregroundColor(theme.getDarkerColor(color: theme.taskColors[task.color]))
        .font(.caption2)
    }
    
    private func jointUsers() -> [String] {
        return task.users[.joint]!
            .map { $0.username }
            .filter { $0 != signedInUser.user.username }
    }
}

//struct UsernamesView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsernamesView()
//    }
//}
