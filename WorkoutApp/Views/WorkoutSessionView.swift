import SwiftUI

struct WorkoutSessionView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @StateObject private var sessionVM: WorkoutSessionViewModel
    @State private var showingRest = false
    @State private var workoutStartedAt = Date()
    @State private var timer: Timer?
    @State private var elapsedTime: TimeInterval = 0

    init(viewModel: WorkoutViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        _sessionVM = StateObject(wrappedValue: WorkoutSessionViewModel(exercises: viewModel.workout))
    }

    var body: some View {
        VStack(spacing: 20) {
            header
            progressBar
            exerciseInfo
            setTracker
            actionButtons
            Spacer()
            sessionControls
        }
        .padding()
        .navigationTitle("Workout")
        .sheet(isPresented: $showingRest) {
            RestTimerOverlay(isShowing: $showingRest, seconds: sessionVM.restDuration)
        }
        .onAppear { startTimer() }
        .onDisappear { stopTimer() }
        .onChange(of: viewModel.swapTarget) {
            sessionVM.reloadCurrentExercise(from: viewModel.workout)
        }
    }

    // MARK: - Header
    private var header: some View {
        VStack(spacing: 4) {
            Text(sessionVM.currentPhaseDisplay)
                .font(.caption)
                .foregroundColor(.secondary)

            Text("⏱️ \(formatTime(elapsedTime))")
                .font(.headline)
                .monospacedDigit()
        }
    }

    // MARK: - Progress
    private var progressBar: some View {
        VStack {
            ProgressView(value: sessionVM.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .animation(.easeInOut, value: sessionVM.progress)

            Text("\(Int(sessionVM.progress * 100))% Complete")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }

    // MARK: - Exercise Details
    private var exerciseInfo: some View {
        VStack(spacing: 8) {
            Text(sessionVM.currentExercise.exercise.name)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)

            Text("\(sessionVM.currentExercise.sets) sets x \(sessionVM.currentExercise.reps) reps")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Equipment: \(sessionVM.currentExercise.exercise.equipment)")
                .font(.footnote)
                .foregroundColor(.secondary)

            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .overlay(Text("GIF here"))

            ForEach(0..<sessionVM.setWeights.count, id: \.self) { i in
                HStack {
                    Text("Set \(i + 1) Weight:")
                    TextField("Weight", value: $sessionVM.setWeights[i], format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                }
            }
        }
    }

    // MARK: - Set Tracker
    private var setTracker: some View {
        HStack(spacing: 8) {
            ForEach(0..<sessionVM.currentExercise.sets, id: \.self) { i in
                Button(action: {
                    sessionVM.toggleSetCompletion(setIndex: i)
                }) {
                    Image(systemName: sessionVM.isSetCompleted(i) ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(sessionVM.isSetCompleted(i) ? .green : .gray)
                }
            }
        }
        .padding(.top)
    }

    // MARK: - Actions
    private var actionButtons: some View {
        VStack(spacing: 12) {
            if sessionVM.shouldShowRest {
                Button("Start Rest") {
                    showingRest = true
                    sessionVM.startRest()
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
            }

            if sessionVM.canContinue {
                Button("Next Exercise") {
                    sessionVM.goToNextExercise()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            if sessionVM.isWorkoutComplete {
                NavigationLink(
                    destination: WorkoutCompleteView(
                        duration: Int(elapsedTime),
                        workout: viewModel.workout
                    )
                ) {
                    Text("🎉 Finish Workout")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    // MARK: - Controls
    private var sessionControls: some View {
        HStack {
            Button("Swap") {
                viewModel.prepareSwap(
                    for: sessionVM.currentExercise,
                    from: viewModel.allExercises
                )
            }
            .padding()
            .background(Color.orange.opacity(0.2))
            .cornerRadius(8)

            Spacer()

            Button("Pause") {
                stopTimer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
        }
    }

    // MARK: - Timer Logic
    private func startTimer() {
        workoutStartedAt = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime = Date().timeIntervalSince(workoutStartedAt)
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func formatTime(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
