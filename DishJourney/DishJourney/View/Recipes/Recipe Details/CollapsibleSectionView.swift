//
//  CollapsibleSectionView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 11/05/24.
//

import SwiftUI

struct CollapsibleSectionView: View {
    let title: String
    @State private var isExpanded = false
    let content: String

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.primary)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            if isExpanded {
                Text(content)
                    .padding()
                    .transition(.slide)
            }
        }
    }
}

#Preview {
    CollapsibleSectionView(title: "test", content: "test")
}
