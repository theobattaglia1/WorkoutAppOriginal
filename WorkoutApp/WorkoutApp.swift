import SwiftUI

@main
struct WorkoutApp: App {
    @StateObject private var viewModel = WorkoutViewModel()

    var body: some Scene {
        WindowGroup {
            LaunchView(viewModel: viewModel)
        }
    }
}
