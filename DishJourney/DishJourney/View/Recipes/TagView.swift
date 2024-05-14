//
//  TagView.swift
//  DishJourney
//
//  Created by Melissa Zellhuber on 02/05/24.
//

import SwiftUI

struct TagView: View {
    var tag: String
    var onDelete: () -> Void

    var body: some View {
        HStack {
            Text(tag)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding(.all, 8)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
        .cornerRadius(20)
        .animation(.spring(), value: tag)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: "test", onDelete: {})
    }
}
