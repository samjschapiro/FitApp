//
//  NewWorkout.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/11/25.
//

import SwiftUI


struct NewWorkout: View {
    @Binding var isPresented: Bool
    
    @State private var workoutName: String = "Workout"
    
    @State private var elapsedTime: Int = 0
    @State private var timerRunning = true
    @State private var timer: Timer?
    
    @State private var exercises: [WorkoutExercise] = []
    
    var body: some View {
        ZStack {
            Text(timeFormatted(elapsedTime))
                .font(.headline)
                .fontWeight(.medium)
                .monospacedDigit()
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                    saveWorkout()
                }) {
                    Text("Finish")
                        .fontWeight(.bold)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .foregroundColor(Color.green)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .padding(.top, 15)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .onAppear {
            startTimer()
        }
        
        VStack(alignment: .leading, spacing: 5) {
            Spacer(minLength: 10)
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    TextEditor(text: $workoutName)
                        .frame(height: 50)
                        .padding(.leading, 5)
                        .font(.system(.title, weight: .semibold))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.gray, lineWidth: 1)
//                        )
                }
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(exercises) { exercise in
                        WorkoutExerciseView(exercise: exercise)
                    }
                }
                .padding(.bottom, 50)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                VStack {
                    Button(action: {
                        exercises.append(WorkoutExercise(name: "Exercise \(exercises.count + 1)"))
                    }) {
                        Text("Add Exercise")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 12)
                            .padding(.bottom, 12)
                            .foregroundColor(Color.blue)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                    Spacer().frame(height: 30)
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Dismiss")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 12)
                            .padding(.bottom, 12)
                            .foregroundColor(Color.red)
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .transition(.move(edge: .bottom))
            }
            .mask(
                VStack(spacing: 0) {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.0),
                            Color.black.opacity(1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 15)
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(1.0),
                            Color.black.opacity(1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(maxHeight: .infinity)
                }
            )
        }
        .frame(alignment: .leading)
    }
    
    func saveWorkout() {
        print("Saving Workout...")
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 9 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if hours > 0 {
            return String(format: "%01d:%02d:%02d", hours, minutes, seconds)
        } else if minutes > 9 {
            return String(format: "%02d:%02d", minutes, seconds)
        }
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        timer?.invalidate() // Prevent duplicate timers
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedTime += 1
        }
        timerRunning = true
    }
    
    func toggleTimer() {
        if timerRunning {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedTime += 1
            }
        }
        timerRunning.toggle()
    }
}



