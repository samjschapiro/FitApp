//
//  DraggableSheet.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/24/25.
//

import SwiftUI


struct DraggableSheet: View {
    @Binding var sheetOffset: CGFloat  // Permanent offset state.
    @Binding var lastOffset: CGFloat
    let fullPosition: CGFloat
    let closedPosition: CGFloat
    @Binding var showSheet: Bool
    @Binding var workoutStarted: Bool
    
    @State private var currOffset: CGFloat = 0
    @State private var badHeight: Bool = false
    
    @State private var selectionPopupPresented: Bool = false

    // A GestureState for the instantaneous drag translation.
    @GestureState private var dragTranslation: CGFloat = 0

    // A threshold some way between the open and closed positions.
    var threshold: CGFloat = 150

    var body: some View {
        ZStack {
            if selectionPopupPresented {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                // Top drag handle area.
                HStack {
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 40, height: 6)
                        .padding(.top, 6)
                        .padding(.bottom, 5)
                }
                .frame(maxWidth: .infinity)
                .background(selectionPopupPresented ? Color.black.opacity(0.2) : Color.clear)
                
                // Content area.
                NewWorkout(isPresented: $workoutStarted,
                           selectionPopupPresented: $selectionPopupPresented)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -10)
            // The offset is the sum of the permanent offset and the instantaneous drag.
            .offset(y: sheetOffset + dragTranslation)
            .simultaneousGesture(
                DragGesture()
                    .updating($dragTranslation) { value, state, _ in
                        // Update the instantaneous drag so the view exactly follows the finger.
                        if !selectionPopupPresented {
                            state = value.translation.height
                            currOffset = value.translation.height
                            if state < 0 {
                                state = 0
                                badHeight = true
                            }
                            else {
                                badHeight = false
                            }
                        }
                    }
                    .onEnded { value in
                        // Calculate the new permanent offset.
                        if !selectionPopupPresented {
                            let newOffset = value.translation.height
                            if newOffset > threshold {
                                // Animate to the closed (off-screen) position.
                                sheetOffset = currOffset
                                withAnimation(.easeOut(duration: 0.4)) {
                                    sheetOffset = closedPosition
                                }
                            } else {
                                // Otherwise, ease back to the fully open position.
                                if !badHeight {
                                    sheetOffset = currOffset
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        sheetOffset = fullPosition
                                    }
                                    lastOffset = fullPosition
                                }
                            }
                        }
                    }
            )
//            .onAppear {
//                // When the sheet appears, animate it from off-screen to the fully open position.
//                withAnimation(.easeOut(duration: 0.4)) {
//                    sheetOffset = fullPosition
//                    lastOffset = fullPosition
//                }
//            }
            .onChange(of: workoutStarted) { newValue, _ in
                withAnimation(.easeOut(duration: 0.4)) {
                    sheetOffset = closedPosition
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    showSheet = false
                    lastOffset = closedPosition
                }
            }
        }
    }
}
