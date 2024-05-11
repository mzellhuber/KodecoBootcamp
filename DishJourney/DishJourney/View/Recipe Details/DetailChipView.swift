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
        VStack(alignment: .leading) {
            Text(label).font(.headline).foregroundColor(.secondary)
            Text(content).font(.subheadline).fontWeight(.medium).foregroundColor(.primary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
    }
}

#Preview {
    DetailChipView(label: "test", content: "test")
}
