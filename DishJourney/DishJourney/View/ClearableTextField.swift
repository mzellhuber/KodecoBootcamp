//
//  ClearableTextField.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 03/05/24.
//

import SwiftUI

struct ClearableTextField: View {
    var title: String
    @Binding var text: String
    var onCommit: () -> Void = {}
    
    init(_ title: String, text: Binding<String>, onCommit: @escaping () -> Void = {}) {
        self.title = title
        _text = text
        self.onCommit = onCommit
    }

    var body: some View {
        TextField(title, text: $text, onCommit: onCommit)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(
                HStack {
                    Spacer()
                    if !text.isEmpty {
                        Button(action: clearText) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                                .padding(.trailing, 8)
                        }
                        .accessibilityLabel("Clear text")
                    }
                }
            )
    }
    
    private func clearText() {
        text = ""
    }
}

struct ClearableTextField_Previews: PreviewProvider {
    @State static var text = "Sample Text"

    static var previews: some View {
        ClearableTextField("Enter text", text: $text, onCommit: {
            print("Text was committed.")
        })
        .padding()
    }
}
