//
//  EmptyStateView.swift
//  Pexels Viewer
//
//  Created by Melissa Zellhuber on 10/03/24.
//

import SwiftUI

struct EmptyStateView: View {
    var message: String

    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.title)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}
