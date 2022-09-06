//
//  TaskEditingView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 04/09/2022.
//

import SwiftUI

struct TaskEditingView: View {
    
    @Binding var editing: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.red.frame(width: 200, height: 200)
            
            VStack {
                
                Text("Editing")
                
                Button {
                    editing = false
                } label: {
                    Text("done")
                }
            }
        }
        
    }
}

struct TaskEditingView_Previews: PreviewProvider {
    
    @State static var editing = true
    
    static var previews: some View {
        TaskEditingView(editing: $editing)
    }
}
