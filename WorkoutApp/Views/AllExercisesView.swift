import SwiftUI

struct AllExercisesView: View {
    let allExercises: [Exercise]

    var body: some View {
        NavigationView {
            List(allExercises, id: \.id) { ex in
                VStack(alignment: .leading) {
                    Text(ex.name)
                        .font(.headline)
                    Text(ex.description)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("All Exercises")
        }
    }
}
