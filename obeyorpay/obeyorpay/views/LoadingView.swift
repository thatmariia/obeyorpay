//
//  LoadingView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import SwiftUI

struct LoadingView: View {
    
    @State var loadingTxt = "LOADING"
    
    var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    
    var body: some View {
        
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            VStack {
                Image("TransparentIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 2.5)
                
                Spacer().frame(height: 10)
                
                SectionTitleTextView(txt: loadingTxt, centering: true)
                
                Spacer().frame(height: 10)
            }
        }
        .onReceive(timer) { _ in
            loadingTxt += "."
        }
    }

}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
