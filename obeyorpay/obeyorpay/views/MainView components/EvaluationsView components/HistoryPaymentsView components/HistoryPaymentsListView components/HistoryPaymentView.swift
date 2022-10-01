//
//  HistoryPaymentView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 29/09/2022.
//

import SwiftUI

struct HistoryPaymentView: View {
    
    @EnvironmentObject var signedInUser: SignedInUserModel
    
    var payment: PaymentStoreModel
    
    var height: Double
    
    @State var task = TaskStoreModel()
    
    var body: some View {
        ZStack(alignment: .center) {
            
            ProgressBarView(
                color: 0,
                height: height,
                count: 0
            )
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    Text("\( task.title == "" ? "LOADING TASK TITLE..." : task.title.uppercased())")
                        .font(.system(size: 13, weight: .semibold))
                    HStack {
                        Text("DATE:")
                            .font(.caption)
                        Text("\(payment.timestamp, formatter: fullDateFormatter)")
                            .font(.caption)
                    }
                
                    
                }
                
                Spacer()
                //Spacer().frame(height: 3)
                
                Text("€" + String(format: "%.2f", payment.amount) )
                    .font(.system(size: 20, weight: .semibold))
                    .tracking(3)
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .onAppear {
            getTask()
        }
    }
    
    func getTask() {
        DispatchQueue.main.async {
            Task.init {
                do {
                    self.task = try await taskDB.fetchTask(with: payment.taskRef)
                }
            }
        }
    }
}

//struct HistoryPaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryPaymentView()
//    }
//}
