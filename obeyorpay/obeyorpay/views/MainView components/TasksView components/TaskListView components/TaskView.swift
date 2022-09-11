//
//  TaskView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

enum TaskViewPresentation {
    case task
    case inviting
    case editing
}


struct TaskView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var task: TaskStoreModel
    var taskType: TaskTypes
    
    @State var dragAmount = CGSize.zero
    
    @State var presentation: TaskViewPresentation = .task
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            TabView(selection: $presentation) {
                ZStack {
                    Button {
                        print("**** I")
                    } label: {
                        HStack {
                            Text("INVITINGGGG")
                            Spacer()
                        }
                        .background(
                            Rectangle()
                                .fill(.red)
                                .frame(height: 100)
                        )
                    }
                }
                .tag(TaskViewPresentation.inviting)
                
                taskView()
                    .padding(20)
                    .background(
                        progressBar()
                    )
                    .tag(TaskViewPresentation.task)
                
                ZStack {
                    Button {
                        print("**** E")
                    } label: {
                        HStack {
                            Text("EDITINGGGG")
                            Spacer()
                        }
                        .background(
                            Rectangle()
                                .fill(.red)
                                .frame(height: 100)
                        )
                    }
                }
                .tag(TaskViewPresentation.editing)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
        
    }
    
    private func taskView() -> some View {
        return HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    if taskType != .shared {
                        Text("@\(signedInUser.user.username)")
                    }
                    
                    ForEach(jointUsers(), id: \.self) { username in
                        Text(" • @\(username)")
                    }
                }
                .foregroundColor(.white)
                .font(.caption2)
                
                Spacer().frame(height: 5)
                
                Text("\(task.title.uppercased())")
                    .font(.system(size: 20, weight: .semibold))
                
                Text("\(task.currentCount) OUT OF AT \(task.build ? "LEAST" : "MOST") \(task.target)")
                    .font(.caption)
                
                Spacer().frame(height: 10)
            }
            Spacer()
        }
        
    }
    
    private func progressBar() -> some View {
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        width: geometry.size.width,
                        height: 100//geometry.size.height
                    )
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle()
                    .frame(
                        width: min(CGFloat(/*task.currentCount / task.target*/ 0.3) * geometry.size.width, geometry.size.width),
                        height: 100//geometry.size.height
                    )
                    .foregroundColor(Color(UIColor.systemBlue))
            }
            .cornerRadius(20)
            
        }
    }
    
    private func jointUsers() -> [String] {
        return task.users[.joint]!
            .map { $0.username }
            .filter { $0 != signedInUser.user.username }
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(
//            task: TaskCKModel()
//        )
//    }
//}
