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
        "Cable Crossover",
        "Squat (Barbell)",
        "Bicep Curl (Dumbbell)",
        "Triceps Pushdown (Rope)",
        "Plank",
        "Running",
        "Stretching"
    ]
    
    @State private var selectedExercise: String? = nil
    @State private var searchText: String = ""
    @Binding var isPresented: Bool
    var onAdd: (String) -> Void

    var filteredExercises: [String] {
        searchText.isEmpty ? exercises : exercises.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }

            VStack(spacing: 10) {
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.3))
                            )
                    }

                    Spacer()
                }
                .padding(.leading, 15)
                .padding(.trailing, 10)

                TextField("Search exercises...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Use List for better performance and appearance
                List(filteredExercises, id: \.self) { exercise in
                    HStack {
                        Text(exercise)
                            .foregroundColor(.primary)
                            .fontWeight(.medium)

                        Spacer()

                        if selectedExercise == exercise {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(selectedExercise == exercise ? Color.blue.opacity(0.1) : Color.clear)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            selectedExercise = (selectedExercise == exercise) ? nil : exercise
                        }
                    }
//                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] + 1 }
                    .alignmentGuide(.listRowSeparatorTrailing) { d in d[.trailing] - 1 }
                }
                .listStyle(PlainListStyle()) // Removes default section padding
//                Spacer().frame(width: 5)

                HStack {
                    Spacer()
                    Button(action: {
                        if let selected = selectedExercise {
                            onAdd(selected) // Adds exercise to list
                            isPresented = false
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add")
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .background(selectedExercise != nil ? Color.blue : Color.gray.opacity(0.3))
                        .foregroundColor(selectedExercise != nil ? .white : .black)
                        .cornerRadius(10)
                    }
                    .disabled(selectedExercise == nil)
                }
                .padding([.horizontal, .bottom])
            }
            .padding(.top)
            .frame(width: UIScreen.main.bounds.width * 0.92, height: UIScreen.main.bounds.height * 0.87)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .offset(y: -20)
        }
    }
}

//struct ExercisePopup_Previews: PreviewProvider {
//    static var previews: some View {
//        ExercisePopup(isPresented: .constant(true), onAdd: { _ in })
//    }
//}






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
