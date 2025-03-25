import Foundation

class WorkoutViewModelMock: WorkoutViewModel {
    init(workout: [WorkoutExercise]) {
        super.init()
        self.workout = workout
    }

    override init() {
        super.init()
    }
}
