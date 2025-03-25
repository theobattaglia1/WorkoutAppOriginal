//
//  WorkoutSessionView.swift
//  GPTWorkoutApp
//
//  Created by Theo Battaglia on 3/25/25.
//


import SwiftUI

struct WorkoutSessionView: View {
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        VStack(spacing: 20) {
            if let exercise = viewModel.currentExercise {
                Text(exercise.name)
                    .font(.largeTitle)
                    .bold()

                if let structure = exercise.structure {
                    Text(structure)
                        .font(.headline)
                        .foregroundColor(.blue)
                }

                Text("Sets: \(exercise.sets)")
                Text("Reps: \(exercise.reps)")
                if let rest = exercise.rest {
                    Text("Rest: \(rest)")
                }

                if let load = exercise.recommended_load {
                    Text("Load: \(load)")
                        .foregroundColor(.gray)
                }

                Button("✅ Complete Exercise") {
                    viewModel.markExerciseComplete(exercise)
                    viewModel.goToNextExercise()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
            } else if viewModel.isWorkoutComplete {
                NavigationLink(destination: WorkoutCompleteView(duration: 45, workout: viewModel.workout)) {
                    Text("🎉 Finish Workout")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .navigationTitle("Workout Session")
    }
}
