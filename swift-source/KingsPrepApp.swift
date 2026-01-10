//
//  KingsPrepApp.swift
//  KingsPrep
//
//  Main app entry point
//

import SwiftUI

@main
struct KingsPrepApp: App {
    init() {
        // Configure app on launch
        configureApp()
    }
    
    var body: some Scene {
        WindowGroup {
            LandingView()
                .preferredColorScheme(.dark) // Force dark mode
        }
    }
    
    private func configureApp() {
        // Print available fonts for debugging
        #if DEBUG
        printAvailableFonts()
        #endif
    }
    
    private func printAvailableFonts() {
        print("📝 Available Font Families:")
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("  - \(family): \(names)")
        }
    }
}

