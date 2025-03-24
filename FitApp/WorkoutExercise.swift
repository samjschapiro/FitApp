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

struct SetItem: Identifiable {
    let id: UUID = UUID()
    var type: String
    var first: String
    var second: String
    var completed: Bool
}

struct WorkoutExerciseView: View {
    var exercise: WorkoutExercise
    
    @State private var prevSets = [
        "45 lb x 12 (W)",
        "135 lb x 10",
        "155 lb x 6 (F)"
    ]
    
    @State private var sets: [SetItem] = [
        SetItem(type: "", first: "", second: "", completed: false)
//        SetItem(type: "", first: "", second: "", completed: false),
//        SetItem(type: "", first: "", second: "", completed: false),
//        SetItem(type: "", first: "", second: "", completed: false)
    ]

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(exercise.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding(.leading, 5)
            }
            .frame(height: 25)
            
            GeometryReader { geometry in
                let totalWidth = geometry.size.width
                
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: totalWidth * 0.01)
                        Text("Set")
                            .frame(width: totalWidth * 0.08, alignment: .center)
                            .fontWeight(.semibold)
                        Text("Previous")
                            .frame(width: totalWidth * 0.39, alignment: .center)
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
                        Spacer()
                            .frame(width: totalWidth * 0.01)
                    }
                    
                    let completedGreen = Color.green.opacity(0.2)

                    List {
                        ForEach(sets.indices, id: \.self) { index in
                            HStack {
                                Spacer().frame(width: totalWidth * 0.01)
                                
                                // Set Number
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(sets[index].completed ? Color.green.opacity(0) : Color.gray.opacity(0.2))
                                        .frame(width: 26, height: 21)
                                    
                                    Text("\(index + 1)")
                                        .foregroundColor(.black)
                                        .fontWeight(.medium)
                                }
                                .frame(width: totalWidth * 0.08, alignment: .center)
                                
                                // Previous Text
                                if index < prevSets.count {
                                    Text(prevSets[index])
                                        .frame(width: totalWidth * 0.39, alignment: .center)
                                        .foregroundColor(Color.gray)
                                        .fontWeight(.medium)
                                } else {
                                    Spacer().frame(width: totalWidth * 0.16)
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: totalWidth * 0.12, height: 4)
                                        .cornerRadius(4)
                                    Spacer().frame(width: totalWidth * 0.155)
                                }
                                
                                // Weight TextField (Not interactive outside of input)
                                AutoSelectTextField(
                                    text: $sets[index].first,
                                    keyboardType: .numberPad,
                                    backgroundColor: sets[index].completed ? Color.green.opacity(0) : Color.gray.opacity(0.2)
                                )
                                .frame(width: totalWidth * 0.17, height: 25, alignment: .center)
                                .fontWeight(.medium)
                                
                                // Reps TextField
                                AutoSelectTextField(
                                    text: $sets[index].second,
                                    keyboardType: .numberPad,
                                    backgroundColor: sets[index].completed ? Color.green.opacity(0) : Color.gray.opacity(0.2)
                                )
                                .frame(width: totalWidth * 0.17, height: 25, alignment: .center)
                                .fontWeight(.bold)
                                
                                // Checkmark Button (Only this triggers the state change)
                                Button(action: {
                                    if sets[index].first.isEmpty || sets[index].second.isEmpty {
                                        triggerHapticFeedbackMedium()
                                    } else {
                                        sets[index].completed.toggle()
                                        if sets[index].completed {
                                            triggerHapticFeedbackLight()
                                        }
                                    }
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(sets[index].completed ? Color.green : Color.gray.opacity(0.2))
                                            .frame(width: 26, height: 21)
                                        
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .frame(width: 12, height: 12)
                                            .foregroundColor(sets[index].completed ? .white : .black)
                                    }
                                }
                                .frame(width: totalWidth * 0.08, alignment: .center)
                                .buttonStyle(.plain)
                                
                                Spacer().frame(width: totalWidth * 0.01)
                            }
                            .frame(height: 35)
                            .background(sets[index].completed ? completedGreen : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .contentShape(Rectangle())
                        }
                        .onDelete(perform: deleteAt)
                    }
                    .listStyle(.plain)
                    .frame(height: 100 + CGFloat(sets.count) * 40)
                }
            }
            .frame(minHeight: CGFloat(30 + sets.count * 44))
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    let newSet = SetItem(type: "", first: "", second: "", completed: false)
                    sets.append(newSet)
                }
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(10)
    }
    
    func deleteAt(offsets: IndexSet) {
        sets.remove(atOffsets: offsets)
    }
}
