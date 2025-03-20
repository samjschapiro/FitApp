//
//  ExerciseSelection.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/19/25.
//

import SwiftUI


struct ExercisePopup: View {
    let exercises = ["Bench Press (Barbell)", "Squat (Barbell)", "Bicep Curl (Dumbbell)", "Triceps Pushdown (Rope)", "Plank"]
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
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.8)
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
