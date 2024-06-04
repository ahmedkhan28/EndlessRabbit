//
//  ContentView.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//
// ContentView.swift
// EndlessRabbit
//
// Created by Ahmed Khan on 04/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameViewControllerWrapper()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
    }
}

struct GameViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = GameViewController
    
    func makeUIViewController(context: Context) -> GameViewController {
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen // Set the presentation style to fullScreen
        return gameViewController
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        // Update the UI view controller if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: GameViewControllerWrapper
        
        init(_ parent: GameViewControllerWrapper) {
            self.parent = parent
        }
    }
}
