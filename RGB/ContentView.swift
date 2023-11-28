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
    @State private var buttonColor: Color = Color.blue

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            if isLandscape {
                landscapeView
            } else {
                portraitView
            }
        }
    }

    var titleAndInstructions: some View {
        VStack {
            Text("RGB")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Adjust the sliders to mix your color")
                .font(.subheadline)
                .padding(.top)
        }
    }

    var portraitView: some View {
        VStack {
            titleAndInstructions
            ColorDisplayView(redValue: redValue, greenValue: greenValue, blueValue: blueValue)
            slidersAndButton
        }
    }

    var landscapeView: some View {
        HStack {
            VStack {
                titleAndInstructions
                ColorSlider(value: $redValue, textColor: .red)
                ColorSlider(value: $greenValue, textColor: .green)
                ColorSlider(value: $blueValue, textColor: .blue)
                SetColorButton(color: buttonColor, action: changeButtonColor)
            }
            
            VStack {
                ColorDisplayView(redValue: redValue, greenValue: greenValue, blueValue: blueValue)
            }
        }
    }

    var slidersAndButton: some View {
        VStack {
            ColorSlider(value: $redValue, textColor: .red)
            ColorSlider(value: $greenValue, textColor: .green)
            ColorSlider(value: $blueValue, textColor: .blue)
            SetColorButton(color: buttonColor, action: changeButtonColor)
        }
    }

    func changeButtonColor() {
        buttonColor = Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255)
    }
}

struct ColorDisplayView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double

    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255))
            .frame(height: 200)
            .shadow(radius: 10)
            .padding()
    }
}

struct SetColorButton: View {
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Set Color")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
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
