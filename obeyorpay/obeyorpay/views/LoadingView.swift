//
//  LoadingView.swift
//  obeyorpay
//
//  Created by Mariia Steeghs-Turchina on 07/09/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        ZStack {
            theme.backgroundColor.ignoresSafeArea()
            VStack {
                Text("Loading....")
                    .foregroundColor(theme.textColor)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
