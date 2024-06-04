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
            .ignoresSafeArea()
    }
}

struct GameViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = GameViewController

    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
