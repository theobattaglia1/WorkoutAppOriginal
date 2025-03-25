//
//  SettingsView.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/23/25.
//


import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Coming Soon")) {
                    Text("Settings options will go here.")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
