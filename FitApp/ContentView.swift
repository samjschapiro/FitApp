//
//  ContentView.swift
//  FitApp
//
//  Created by Matthew Finkel on 3/11/25.
//

import SwiftUI


struct ContentView: View {
    @State private var workoutStarted = false
    @State private var workoutExpanded = true
    @State private var selectedDetent: PresentationDetent = .large
    
    @State private var showSheet = false
    @State private var sheetOffset: CGFloat = 0    // Current vertical offset for the sheet
    @State private var lastOffset: CGFloat = 0
    let fullPosition: CGFloat = 0                  // Fully expanded sheet starts 50pt from the top
    let closedPosition: CGFloat = 800              // Fully closed/off-screen position
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("FitApp")
                        .font(.largeTitle)
                        .padding(.top, 8)
                        .padding(.leading, 8)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 20)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        GeometryReader { geometry in
                            ScrollView(.vertical, showsIndicators: true) {
                                VStack {
                                    FeedItem(
                                        title: "Placeholder: Workout Summary",
                                        icon: "figure.walk",
                                        description: "Placeholder: You completed a 5K run today!")
                                    FeedItem(
                                        title: "Placeholder: New Meal Logged",
                                        icon: "carrot",
                                        description: "Placeholder: You had a healthy salad for lunch.")
                                    FeedItem(
                                        title: "Placeholder: Goal Achieved",
                                        icon: "star.fill",
                                        description: "Placeholder: You reached your weekly fitness goal!")
                                    FeedItem(
                                        title: "Placeholder: Workout Summary",
                                        icon: "figure.walk",
                                        description: "Placeholder: You completed a 5K run today!")
                                    FeedItem(
                                        title: "Placeholder: New Meal Logged",
                                        icon: "carrot",
                                        description: "Placeholder: You had a healthy salad for lunch.")
                                    FeedItem(
                                        title: "Placeholder: Goal Achieved",
                                        icon: "star.fill",
                                        description: "Placeholder: You reached your weekly fitness goal!")
                                    FeedItem(
                                        title: "Placeholder: Workout Summary",
                                        icon: "figure.walk",
                                        description: "Placeholder: You completed a 5K run today!")
                                    FeedItem(
                                        title: "Placeholder: New Meal Logged",
                                        icon: "carrot",
                                        description: "Placeholder: You had a healthy salad for lunch.")
                                    FeedItem(
                                        title: "Placeholder: Goal Achieved",
                                        icon: "star.fill",
                                        description: "Placeholder: You reached your weekly fitness goal!")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.top, 5)
                            }
                            .frame(height: geometry.size.height)
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
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.black.opacity(1.0),
                                            Color.black.opacity(0.0)
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .frame(height: 15)
                                }
                                .frame(height: geometry.size.height)
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 5)
                    
                    Spacer()
                    
                    HStack {
                        VStack {
                            Button(action: { print("Home tapped") }) {
                                Image(systemName: "house")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                                    .frame(width: 30, height: 30)
                            }
                            Text("Home").font(.caption)
                        }
                        Spacer()
                        VStack {
                            Button(action: { print("Meals tapped") }) {
                                Image(systemName: "carrot")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                                    .frame(width: 30, height: 30)
                            }
                            Text("Meals").font(.caption)
                        }
                        Spacer()
                        VStack {
                            Button(action: {
                                if !workoutStarted {
                                    workoutStarted.toggle()  // Start workout
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        showSheet = true
                                    }
                                }
                                withAnimation(.easeOut(duration: 0.4)) {
                                    sheetOffset = fullPosition
                                    lastOffset = closedPosition
                                }
                            }) {
                                Image(systemName: !workoutStarted ? "plus" : "arrow.up")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24, weight: .semibold))
                                    .frame(width: 30, height: 30)
                            }
                            Text(!workoutStarted ? "Workout" : "Resume")
                                .font(.caption)
                        }
                        Spacer()
                        VStack {
                            Button(action: { print("History tapped") }) {
                                Image(systemName: "clock")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                            }
                            Text("History").font(.caption)
                        }
                        Spacer()
                        VStack {
                            Button(action: { print("Profile tapped") }) {
                                Image(systemName: "person")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                                    .frame(width: 30, height: 30)
                            }
                            Text("Profile").font(.caption)
                        }
                    }
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor.systemBackground))
            }
            
            
            if showSheet {
                DraggableSheet(sheetOffset: $sheetOffset,
                               lastOffset: $lastOffset,
                               fullPosition: fullPosition,
                               closedPosition: closedPosition,
                               showSheet: $showSheet,
                               workoutStarted: $workoutStarted)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}


#Preview {
    ContentView()
}
