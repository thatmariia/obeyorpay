//
//  TargetInputView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 11/09/2022.
//

import SwiftUI

struct TargetInputView: View {
    
    @Binding var build: Int
    @Binding var target: String
    
    var showingTargetNote: Bool
    var targetNote: String
    var color: Int
    
    var editing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleTextView(txt: "TARGET")
            HStack {
                // build (at most vs at least)
                if !editing {
                    Menu() {
                        Button {
                            build = 1
                        } label: {
                            Text("AT LEAST")
                                .foregroundColor(theme.textColor)
                                .font(.system(size: 16, weight: .medium))
                        }
                        
                        Button {
                            build = 0
                        } label: {
                            Text("AT MOST")
                                .foregroundColor(theme.textColor)
                                .font(.system(size: 16, weight: .medium))
                        }
                        
                    } label: {
                        HStack {
                            Text(build == 1 ? "at least" : "at most")
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(theme.taskColors[color])
                        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                        .background {
                            Rectangle()
                                .foregroundColor(theme.cardColor)
                                .cornerRadius(20)
                                .shadow(color: theme.shadowColor, radius: 10, x: 10, y: 10)
                        }
                    }
                } else {
                    Text(build == 1 ? "at least" : "at most")
                        .foregroundColor(theme.unselectedTextColor)
                        .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                        .background {
                            Rectangle()
                                .foregroundColor(theme.cardColor)
                                .cornerRadius(20)
                                .shadow(color: theme.shadowColor, radius: 10, x: 10, y: 10)
                        }
                }
                
                Spacer().frame(width: 30)
                
                // target
                TextField("TARGET", text: $target)
                    .frame(width: 100)
                    .textFieldStyle(AppTextfieldStyle(accentColor: theme.unselectedTextColor, foregroundColor: theme.taskColors[color]))
                    .keyboardType(.numberPad)
                if showingTargetNote {
                    Text(targetNote)
                }
            }
            .font(.system(size: 16, weight: .medium))
        }
    }
}

//struct TargetInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        TargetInputView()
//    }
//}
