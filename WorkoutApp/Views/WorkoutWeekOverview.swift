//
//  WorkoutWeekOverview.swift
//  WorkoutApp
//
//  Created by Theo Battaglia on 3/25/25.
//



import SwiftUI

struct WorkoutWeekOverview: View {
    let plan: WorkoutPlan
    @ObservedObject var viewModel: WorkoutViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(plan.week_plan, id: \.day) { day in
                    WorkoutSessionLauncher(day: day, viewModel: viewModel)
                        .padding(.vertical, 4)
                }
            }
            .navigationTitle(plan.title)
        }
    }
}
