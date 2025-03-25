//
//  Numpad.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/24/25.
//

import SwiftUI


//struct Numpad: View {
//    var onKeyPress: (String) -> Void
//    var onDelete: () -> Void
//    var onDone: () -> Void
//
//    let buttons = [
//        ["1", "2"],
//        ["4", "5"],
//        ["7", "8"],
//        [".", "0"]
//    ]
//
//    var body: some View {
//        ZStack {
//            Color.gray.opacity(0.05)
//            HStack {
//                VStack(spacing: 12) {
////                    Spacer().frame(height: 12)
//                    
//                    ForEach(buttons, id: \.self) { row in
//                        HStack(spacing: 10) {
//                            ForEach(row, id: \.self) { key in
//                                Button(action: {
//                                    onKeyPress(key)
//                                }) {
//                                    Text(key)
//                                        .font(.title3)
//                                        .fontWeight(.semibold)
//                                        .frame(width: 80, height: 52)
//                                        .background(Color.gray.opacity(0.2))
//                                        .foregroundColor(.black)
//                                        .cornerRadius(8)
//                                }
//                            }
//                        }
//                    }
//                }
////                .padding(.vertical)
//                
//                VStack(spacing: 12) {
////                    Spacer().frame(height: 12)
//                    
//                    Button(action: {
//                        onKeyPress("3")
//                    }) {
//                        Text("3")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .frame(width: 80, height: 52)
//                            .background(Color.gray.opacity(0.2))
//                            .foregroundColor(.black)
//                            .cornerRadius(8)
//                    }
//                    Button(action: {
//                        onKeyPress("6")
//                    }) {
//                        Text("6")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .frame(width: 80, height: 52)
//                            .background(Color.gray.opacity(0.2))
//                            .foregroundColor(.black)
//                            .cornerRadius(8)
//                    }
//                    Button(action: {
//                        onKeyPress("9")
//                    }) {
//                        Text("9")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .frame(width: 80, height: 52)
//                            .background(Color.gray.opacity(0.2))
//                            .foregroundColor(.black)
//                            .cornerRadius(8)
//                    }
//                    Button(action: {
//                        onDelete()
//                    }) {
//                        Image(systemName: "delete.left")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 22, height: 22)
//                            .foregroundColor(.black)
//                            .padding()
//                            .frame(width: 80, height: 52)
//                            .background(Color.gray.opacity(0.2))
//                            .cornerRadius(8)
//                    }
//                }
////                .padding(.vertical)
//                
//                VStack(spacing: 12) {
////                    Spacer().frame(height: 12)
//                    
//                    ForEach([
//                        "keyboard.chevron.compact.down",
//                        //                    "flame.fill",
//                        //                    "clock.fill",
//                        //                    "star.fill"
//                    ], id: \.self) { systemImage in
//                        Button(action: {
//                            // You can map each symbol to a function if needed
//                            if systemImage == "keyboard.chevron.compact.down" {
//                                onDone()
//                            }
//                        }) {
//                            Image(systemName: systemImage)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 22, height: 22)
//                                .foregroundColor(.black)
//                                .padding()
//                                .frame(width: 80, height: 245)  // 45
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(8)
//                        }
//                    }
//                }
////                .padding(.vertical)
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .ignoresSafeArea(.all)
//    }
//}
//
//
//struct CustomKeypadInContextPreview: View {
//    @State private var showKeypad = true
//    @State private var inputText = ""
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Workout Exercise")
//                .font(.title)
//                .padding(.top)
//
//            Text("lbs: \(inputText)")
//                .frame(width: 100, height: 40)
//                .background(Color.gray.opacity(0.2))
//                .cornerRadius(6)
//                .onTapGesture {
//                    showKeypad = true
//                }
//
//            Spacer()
//        }
//        .padding()
//        .sheet(isPresented: $showKeypad) {
//            Numpad(
//                onKeyPress: { char in
//                    inputText.append(char)
//                },
//                onDelete: {
//                    inputText = String(inputText.dropLast())
//                },
//                onDone: {
//                    showKeypad = false
//                }
//            )
//            .presentationDetents([.fraction(0.35)])
////            .presentationDragIndicator(.visible)
//        }
//    }
//}
//
//struct CustomKeypadInContextPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomKeypadInContextPreview()
//    }
//}












struct Numpad: View {
    var focusedField: String?
    var textFields: [String: Binding<String>]
    var onDone: () -> Void

    let buttons = [
        ["1", "2"],
        ["4", "5"],
        ["7", "8"],
        [".", "0"]
    ]

    private func insert(_ key: String) {
        guard let focused = focusedField,
              let binding = textFields[focused] else { return }

        binding.wrappedValue.append(key)
    }

    private func delete() {
        guard let focused = focusedField,
              let binding = textFields[focused],
              !binding.wrappedValue.isEmpty else { return }

        binding.wrappedValue.removeLast()
    }

    var body: some View {
        ZStack {
            Color.gray.opacity(0.05)
            HStack {
                // LEFT COLUMN
                VStack(spacing: 12) {
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(row, id: \.self) { key in
                                Button(action: {
                                    insert(key)
                                }) {
                                    Text(key)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .frame(width: 80, height: 52)
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }

                // MIDDLE COLUMN
                VStack(spacing: 12) {
                    ForEach(["3", "6", "9"], id: \.self) { key in
                        Button(action: {
                            insert(key)
                        }) {
                            Text(key)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(width: 80, height: 52)
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }

                    Button(action: {
                        delete()
                    }) {
                        Image(systemName: "delete.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 80, height: 52)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }

                // RIGHT COLUMN
                VStack(spacing: 12) {
                    Button(action: {
                        onDone()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 80, height: 245)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}


struct CustomKeypadInContextPreview: View {
    @State private var showKeypad = true
    @State private var inputText1 = ""
    @State private var inputText2 = ""
    @State private var focusedField: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Workout Exercise")
                .font(.title)
                .padding(.top)

            Text("lbs: \(inputText1)")
                .frame(width: 100, height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .onTapGesture {
                    focusedField = "field1"
                    showKeypad = true
                }

            Text("reps: \(inputText2)")
                .frame(width: 100, height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .onTapGesture {
                    focusedField = "field2"
                    showKeypad = true
                }

            Spacer()
        }
        .padding()
        .sheet(isPresented: $showKeypad) {
            Numpad(
                focusedField: focusedField,
                textFields: [
                    "field1": $inputText1,
                    "field2": $inputText2
                ],
                onDone: {
                    showKeypad = false
                }
            )
            .presentationDetents([.fraction(0.35)])
            .presentationBackgroundInteraction(.enabled)
        }
    }
}

struct CustomKeypadInContextPreview_Previews: PreviewProvider {
    static var previews: some View {
        CustomKeypadInContextPreview()
    }
}

