//
//  WorkoutProgressBar.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import SwiftUI

struct WorkoutProgressBar: View {
    let phase: WorkoutPhase
    let index: Int
    let total: Int

    private var phaseTitle: String {
        switch phase {
        case .warmUp: return "Warm-Up"
        case .main: return "Main"
        case .accessory: return "Accessory"
        case .finisher: return "Finisher"
        }
    }

    private var progress: Double {
        guard total > 0 else { return 0 }
        return Double(index + 1) / Double(total)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Phase: \(phaseTitle)")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(index + 1)/\(total)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(height: 8)
                        .foregroundColor(Color.gray.opacity(0.3))

                    Capsule()
                        .frame(width: CGFloat(progress) * geometry.size.width, height: 8)
                        .foregroundColor(Color.green)
                        .animation(.easeInOut(duration: 0.5), value: progress)
                }
            }
            .frame(height: 8)
        }
        .padding(.top, 8)
    }
}
