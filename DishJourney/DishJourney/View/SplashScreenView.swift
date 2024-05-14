//
//  SplashScreenView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 05/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text("DishJourney")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 82/255, green: 180/255, blue: 142/255))
        .ignoresSafeArea()
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
