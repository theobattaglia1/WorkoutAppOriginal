import SwiftUI

struct MainTabView: View {
    let allExercises: [Exercise]
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        TabView {
            // 🔹 NEW: User input screen to generate tailored workouts
            WorkoutInputView(viewModel: viewModel)
                .tabItem {
                    Label("Build", systemImage: "slider.horizontal.3")
                }

            // 🔹 Existing: View generated workout and interact with it
            WorkoutView(viewModel: viewModel, allExercises: allExercises)
                .tabItem {
                    Label("Workout", systemImage: "bolt.fill")
                }

            // 🔹 View saved past workouts
            SavedWorkoutsView(viewModel: viewModel)
                .tabItem {
                    Label("Saved", systemImage: "tray.full.fill")
                }

            // 🔹 View all raw exercises
            AllExercisesView(allExercises: allExercises)
                .tabItem {
                    Label("Exercises", systemImage: "list.bullet.rectangle")
                }

            // 🔹 Placeholder for settings
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
