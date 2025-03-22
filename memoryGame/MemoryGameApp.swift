//
//  MemoryGameApp.swift
//
//  Created by Lisa Jo on 3/18/25.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    @StateObject private var viewModel = MemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            MemoryGameView(viewModel: viewModel
            )
        }
    }
}
