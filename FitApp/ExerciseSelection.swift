//
//  ExerciseSelection.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/19/25.
//

import SwiftUI


struct ExercisePopup: View {
    let exercises = [
        "Bench Press (Barbell)",
        "Squat (Barbell)",
        "Bicep Curl (Dumbbell)",
        "Triceps Pushdown (Rope)",
        "Plank"
    ]
    
    @State private var selectedExercise: String? = nil
    @Binding var isPresented: Bool
    
    var onAdd: (String) -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 20) {
                Text("Select an Exercise")
                    .font(.headline)
                    .padding()
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(exercises, id: \.self) { exercise in
                            HStack {
                                Text(exercise)
                                    .font(.body)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                if selectedExercise == exercise {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedExercise == exercise ? Color.blue : Color.gray, lineWidth: 2))
                            .onTapGesture {
                                selectedExercise = exercise
                            }
                        }
                    }
                    .padding()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        if let selected = selectedExercise {
                            onAdd(selected)
                            isPresented = false
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add")
                        }
                        .padding()
                        .background(selectedExercise != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(selectedExercise == nil)
                }
                .padding()
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.8)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}

struct ExercisePopup_Previews: PreviewProvider {
    static var previews: some View {
        ExercisePopup(isPresented: .constant(true), onAdd: { _ in })
    }
}


//import SwiftUI
//
//// Model for Exercise
//struct Exercise: Identifiable {
//    let id = UUID()
//    let name: String
//}
//
//// View Model to manage exercise selection
//class ExerciseSelectionViewModel: ObservableObject {
//    // Predefined list of exercises
//    let availableExercises = [
//        "Bench Press",
//        "Squats",
//        "Deadlifts",
//        "Shoulder Press",
//        "Bicep Curls",
//        "Tricep Extensions",
//        "Leg Press",
//        "Pull-ups",
//        "Push-ups",
//        "Lunges"
//    ]
//    
//    @Published var searchText = ""
//    @Published var selectedExercise: String? = nil
//    
//    // Filtered exercises based on search
//    var filteredExercises: [String] {
//        if searchText.isEmpty {
//            return availableExercises
//        } else {
//            return availableExercises.filter {
//                $0.localizedCaseInsensitiveContains(searchText)
//            }
//        }
//    }
//}
//
//// Popup View for Adding Exercise
//struct AddExercisePopupView: View {
//    @Binding var isPresented: Bool
//    @StateObject private var viewModel = ExerciseSelectionViewModel()
//    var onExerciseSelected: (String) -> Void
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Search Bar
//                TextField("Search exercises", text: $viewModel.searchText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                // Exercise List
//                List(viewModel.filteredExercises, id: \.self) { exercise in
//                    Button(action: {
//                        viewModel.selectedExercise = exercise
//                        onExerciseSelected(exercise)
//                        isPresented = false
//                    }) {
//                        Text(exercise)
//                    }
//                }
//            }
//            .navigationTitle("Add Exercise")
//            .navigationBarItems(trailing:
//                Button("Cancel") {
//                    isPresented = false
//                }
//            )
//        }
//    }
//}
//
//// Example Usage in a Parent View
//struct WorkoutView: View {
//    @State private var showingAddExercisePopup = false
//    @State private var selectedExercises: [String] = []
//    
//    var body: some View {
//        VStack {
//            // Your existing workout view content
//            
//            Button("Add Exercise") {
//                showingAddExercisePopup = true
//            }
//            .sheet(isPresented: $showingAddExercisePopup) {
//                AddExercisePopupView(
//                    isPresented: $showingAddExercisePopup,
//                    onExerciseSelected: { exercise in
//                        selectedExercises.append(exercise)
//                    }
//                )
//            }
//            
//            // Display selected exercises
//            List(selectedExercises, id: \.self) { exercise in
//                Text(exercise)
//            }
//        }
//    }
//}
