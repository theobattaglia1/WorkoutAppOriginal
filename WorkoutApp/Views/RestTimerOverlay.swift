import SwiftUI

struct RestTimerOverlay: View {
    @Binding var isShowing: Bool
    let seconds: Int

    @State private var remaining: Int
    @State private var timer: Timer?

    init(isShowing: Binding<Bool>, seconds: Int) {
        self._isShowing = isShowing
        self.seconds = seconds
        self._remaining = State(initialValue: seconds)
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Rest Time")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Text("\(remaining)s")
                    .font(.system(size: 72, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)

                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 12)
                    .frame(width: 160, height: 160)
                    .overlay(
                        Circle()
                            .trim(from: 0, to: CGFloat(remaining) / CGFloat(seconds))
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut(duration: 1), value: remaining)
                    )

                Button(action: {
                    endRest()
                }) {
                    Text("Skip Rest")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(12)
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remaining > 0 {
                remaining -= 1
            } else {
                endRest()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func endRest() {
        stopTimer()
        isShowing = false
    }
}
