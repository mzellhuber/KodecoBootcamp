//
//  ContentView.swift
//  RGB
//
//  Created by Melissa Zellhuber on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue: Double = 128
    @State private var greenValue: Double = 128
    @State private var blueValue: Double = 128
    @State private var rgbText: String = ""
    
    var body: some View {
        VStack {
            Text("RGB")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255))
                .frame(height: 200)
                .shadow(radius: 10)
                .padding(.horizontal)
            
            Text("Adjust the sliders to mix your color")
                .font(.subheadline)
                .padding(.top)
            
            ColorSlider(value: $redValue, textColor: .red)
            ColorSlider(value: $greenValue, textColor: .green)
            ColorSlider(value: $blueValue, textColor: .blue)
            
            if !rgbText.isEmpty {
                Text(rgbText)
                    .font(.headline)
                    .padding()
            }
            
            Button(action: {
                rgbText = "RGB(\(Int(redValue)), \(Int(greenValue)), \(Int(blueValue)))"
            }) {
                Text("Set Color")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()
        }
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(textColor)
            Text("\(Int(value))").foregroundColor(textColor)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
