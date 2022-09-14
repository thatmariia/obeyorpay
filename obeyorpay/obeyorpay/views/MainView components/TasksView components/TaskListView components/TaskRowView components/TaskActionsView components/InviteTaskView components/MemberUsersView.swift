//
//  MemberUsersView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 14/09/2022.
//

import SwiftUI

struct MemberUsersView: View {
    
    var task: TaskStoreModel
    var taskInvitedType: TaskTypes
    
    var body: some View {
        VStack {
            // list all joint
            ForEach(task.users[taskInvitedType]!) { user in
                HStack {
                    Text("@" + user.username)
                        .font(.system(size: 15, weight: .medium))
                    Spacer()
                }
            }
            
            // list all invited
            ForEach(task.invitedUsers[taskInvitedType]!) { user in
                HStack {
                    Text(user.username)
                        .font(.system(size: 15, weight: .medium))
                    Spacer()
                    Text("(invited)")
                        .foregroundColor(theme.taskColors[task.color])
                        .font(.system(size: 13, weight: .regular).italic())
                }
            }
        }
        .padding()
        .background {
            Rectangle()
                .foregroundColor(theme.cardColor)
                .cornerRadius(20)
                .shadow(
                    color: theme.shadowColor,
                    radius: 10,
                    x: 10,
                    y: 10
                )
        }
    }
}

//struct MemberUsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemberUsersView()
//    }
//}
