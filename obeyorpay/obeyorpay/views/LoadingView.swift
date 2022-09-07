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
            Color.yellow
            VStack {
                Text("Loading....")
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}