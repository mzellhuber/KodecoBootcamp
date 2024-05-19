//
//  CollapsibleSectionView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 11/05/24.
//

import SwiftUI

struct CollapsibleSectionView: View {
    let title: String
    let content: String

    @State private var isCollapsed = true

    var body: some View {
        VStack(alignment: .leading) {
            Button(
                action: {
                    withAnimation {
                        isCollapsed.toggle()
                    }
                },
                label: {
                    HStack {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: isCollapsed ? "chevron.down" : "chevron.up")
                            .foregroundColor(.primary)
                    }
                }
            )
            if !isCollapsed {
                Text(content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.top, 5)
            }
        }
    }
}


#Preview {
    CollapsibleSectionView(title: "test", content: "test")
}
