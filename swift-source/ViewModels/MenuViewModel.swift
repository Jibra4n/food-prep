//
//  MenuViewModel.swift
//  KingsPrep
//
//  View model for menu-related logic
//

import Foundation
import SwiftUI

@MainActor
class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []
    @Published var isLoading = false
    @Published var error: String?
    
    /// Load all menu items from the API
    func loadMenuItems() async {
        isLoading = true
        error = nil
        
        do {
            menuItems = try await APIService.shared.fetchMenuItems()
        } catch let apiError as APIError {
            self.error = apiError.localizedDescription
            print("❌ Error loading menu: \(apiError)")
        } catch {
            self.error = error.localizedDescription
            print("❌ Unexpected error: \(error)")
        }
        
        isLoading = false
    }
    
    /// Get all main course items
    var mains: [MenuItem] {
        menuItems.filter { $0.category == Category.main.rawValue }
    }
    
    /// Get all dessert items
    var desserts: [MenuItem] {
        menuItems.filter { $0.category == Category.dessert.rawValue }
    }
    
    /// Find a specific item by ID
    func item(withId id: Int) -> MenuItem? {
        menuItems.first { $0.id == id }
    }
}

