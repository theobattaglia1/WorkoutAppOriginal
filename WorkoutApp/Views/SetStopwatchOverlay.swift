//
//  SetStopwatchOverlay.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/24/25.
//


import SwiftUI

struct SetStopwatchOverlay: View {
    @Binding var isVisible: Bool
    @State private var elapsed: TimeInterval = 0
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            Color.black.opacity(0.85).ignoresSafeArea()
            VStack(spacing: 24) {
                Text("⏱ Stopwatch")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Text(formatTime(elapsed))
                    .font(.system(size: 64, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)

                HStack(spacing: 20) {
                    Button("▶️ Start") {
                        start()
                    }
                    Button("⏸ Pause") {
                        stop()
                    }
                    Button("🔁 Reset") {
                        elapsed = 0
                    }
                }
                .foregroundColor(.white)

                Button("✖️ Close") {
                    isVisible = false
                    stop()
                }
                .padding(.top)
            }
        }
    }

    private func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsed += 1
        }
    }

    private func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func formatTime(_ interval: TimeInterval) -> String {
        let m = Int(interval) / 60
        let s = Int(interval) % 60
        return String(format: "%02d:%02d", m, s)
    }
}
