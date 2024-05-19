//
//  DetailChipView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 11/05/24.
//

import SwiftUI

struct DetailChipView: View {
    let label: String
    let content: String

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            Text(content)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    DetailChipView(label: "test", content: "test")
}
