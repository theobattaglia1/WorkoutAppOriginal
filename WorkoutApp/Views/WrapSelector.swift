//
//  WrapSelector.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import SwiftUI

struct WrapSelector: View {
    let options: [String]
    @Binding var selection: [String]

    var body: some View {
        FlexibleView(data: options, spacing: 8, alignment: .leading) { item in
            Text(item)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(selection.contains(item) ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(selection.contains(item) ? .white : .black)
                .cornerRadius(20)
                .onTapGesture {
                    toggle(item)
                }
        }
    }

    private func toggle(_ item: String) {
        if selection.contains(item) {
            selection.removeAll { $0 == item }
        } else {
            selection.append(item)
        }
    }
}
