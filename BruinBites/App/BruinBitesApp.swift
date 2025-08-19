//
//  BruinBitesApp.swift
//  BruinBites
//
//  Created by Susie Kim on 7/6/25.
//

import SwiftUI
import Firebase

@main
struct BruinBitesApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
