//
//  EndlessRunnerApp.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//
//
//  EndlessRunnerApp.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//
import SwiftUI


struct EndlessRunnerApp: App {
    @State private var showLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showLaunchScreen {
                    LaunchScreenView()
                        .onAppear {
                            // Simulate a delay to show the launch screen for a certain duration
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                showLaunchScreen = false
                            }
                        }
                } else {
                    ContentView()
                        .statusBar(hidden: true)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
        }
    }
}

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                Text("Endless Rabbit")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}
