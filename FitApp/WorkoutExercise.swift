//
//  WorkoutExercise.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/12/25.
//

import SwiftUI


struct WorkoutExercise: Identifiable {
    let id = UUID()
    var name: String
}


struct WorkoutExerciseView: View {
    var exercise: WorkoutExercise
    
    @State private var thingy: String = "1"
    @State private var numSets: Int = 1
    
    @State private var setValues = ["W", "", "F", "", "", "", "", "", "", "",
                                   "", "", "", "", "", "", "", "", "", ""]
    @State private var prevValues = ["25 lb x 12 (W)", "125 lb x 8", "125 lb x 10 (F)", "", "", "", "", "", "", "",
                                     "", "", "", "", "", "", "", "", "", ""]
    @State private var weightValues = ["25", "125", "125", "", "", "", "", "", "", "",
                                       "", "", "", "", "", "", "", "", "", ""]
    @State private var repValues = ["10", "8", "10", "", "", "", "", "", "", "",
                                    "", "", "", "", "", "", "", "", "", ""]
    @FocusState private var focusedField: Int?
    
    @State private var completedSets: Set<Int> = []

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(exercise.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(.leading, 3)
            }
            .frame(height: 25)
            
            GeometryReader { geometry in
                let totalWidth = geometry.size.width
                VStack {
                    HStack {
                        Text("Set")
                            .frame(width: totalWidth * 0.09, alignment: .center)
                            .fontWeight(.semibold)
                        Text("Previous")
                            .frame(width: totalWidth * 0.4, alignment: .center)
                            .fontWeight(.semibold)
                        Text("lbs")
                            .frame(width: totalWidth * 0.17, alignment: .center)
                            .fontWeight(.semibold)
                        Text("Reps")
                            .frame(width: totalWidth * 0.17, alignment: .center)
                            .fontWeight(.semibold)
                        Image(systemName: "checkmark")
                            .frame(width: totalWidth * 0.08, alignment: .center)
                            .fontWeight(.semibold)
                    }
                    
                    let completedGreen = Color.green.opacity(0.2)
                    ForEach(1...numSets, id: \.self) { setNumber in
                        let isCompleted = completedSets.contains(setNumber)
                        
                        HStack {
                            Text("\(setNumber)")
                                .frame(width: totalWidth * 0.09, alignment: .center)
                            
//                            if weightValues[setNumber - 1].isEmpty || repValues[setNumber - 1].isEmpty {
//                                RoundedRectangle(cornerRadius: 2)
//                                    .frame(width: totalWidth * 0.1, height: 3)
//                                    .foregroundColor(.gray.opacity(0.6))
//                                    .padding(.leading, totalWidth * 0.15)
//                                    .padding(.trailing, totalWidth * 0.15)
//                            } else {
//                                Text("\(weightValues[setNumber - 1]) lb x \(repValues[setNumber - 1])\(setValues[setNumber - 1].isEmpty ? "" : " (\(setValues[setNumber - 1]))")")
//                                    .frame(width: totalWidth * 0.4, alignment: .center)
//                            }
                            Text(prevValues[setNumber - 1])
                                .frame(width: totalWidth * 0.4, alignment: .center)
                            
                            AutoSelectTextField(
                                text: $weightValues[setNumber - 1],
                                keyboardType: .numberPad,
                                backgroundColor: isCompleted ? completedGreen : Color.gray.opacity(0.2)
                            )
                            .frame(width: totalWidth * 0.17, height: 25, alignment: .center)
                            
                            AutoSelectTextField(
                                text: $repValues[setNumber - 1],
                                keyboardType: .numberPad,
                                backgroundColor: isCompleted ? completedGreen : Color.gray.opacity(0.2)
                            )
                            .frame(width: totalWidth * 0.17, height: 25, alignment: .center)
                            
                            Button(action: {
                                if completedSets.contains(setNumber) {
                                    completedSets.remove(setNumber)
                                } else {
                                    completedSets.insert(setNumber)
                                    triggerHapticFeedbackLight()
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(completedSets.contains(setNumber) ? Color.green : Color.gray.opacity(0.2))
                                        .frame(width: 26, height: 21)

                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .foregroundColor(completedSets.contains(setNumber) ? .white : .black)
                                }
                            }
                            .frame(width: totalWidth * 0.08, alignment: .center)
//                            .padding(.trailing, 5)
                        }
                        .frame(width: .infinity, height: 42)
                        .background(isCompleted ? completedGreen : Color.clear)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .padding(.top, 1)
//                        .padding(.bottom, 1)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .frame(minHeight: CGFloat(25 + numSets * 50))
//            .fixedSize(horizontal: false, vertical: true)
            
            Button(action: {
                numSets += 1
                print(numSets)
            }) {
                Text("+ Add Set")
                    .frame(maxWidth: .infinity)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .foregroundColor(Color.black)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
            }
        }
//        .frame(width: .infinity)
//        .padding(.top, 5)
//        .padding(.bottom, 5)
//        .padding(.leading, 5)
//        .padding(.trailing, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}
