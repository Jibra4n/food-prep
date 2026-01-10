//
//  OrderViewModel.swift
//  KingsPrep
//
//  View model for order-related logic
//

import Foundation
import SwiftUI

@MainActor
class OrderViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedMain: MenuItem?
    @Published var mainQuantity = 1
    @Published var selectedDessert: MenuItem?
    @Published var dessertQuantity = 0
    @Published var selectedDate: Date = {
        // Default to tomorrow
        Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    }()
    
    @Published var isSubmitting = false
    @Published var orderSuccess = false
    @Published var error: String?
    
    // MARK: - Computed Properties
    
    /// Calculate total price in cents
    var totalPrice: Int {
        var total = 0
        if let main = selectedMain {
            total += main.price * mainQuantity
        }
        if let dessert = selectedDessert, dessertQuantity > 0 {
            total += dessert.price * dessertQuantity
        }
        return total
    }
    
    /// Format total price as currency string
    var formattedTotal: String {
        String(format: "£%.2f", Double(totalPrice) / 100.0)
    }
    
    /// Check if order can be submitted
    var canSubmit: Bool {
        selectedMain != nil && !isSubmitting
    }
    
    // MARK: - Actions
    
    /// Submit the order to the backend
    func submitOrder() async {
        guard let mainId = selectedMain?.id else {
            error = "Please select a main course"
            return
        }
        
        isSubmitting = true
        error = nil
        
        // Format date as YYYY-MM-DD
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: selectedDate)
        
        let orderRequest = CreateOrderRequest(
            mainItemId: mainId,
            mainQuantity: mainQuantity,
            dessertItemId: selectedDessert?.id,
            dessertQuantity: dessertQuantity,
            pickupDate: dateString,
            totalPrice: totalPrice
        )
        
        do {
            _ = try await APIService.shared.createOrder(orderRequest)
            orderSuccess = true
            print("✅ Order submitted successfully!")
        } catch let apiError as APIError {
            self.error = "Failed to place order: \(apiError.localizedDescription)"
            print("❌ Error submitting order: \(apiError)")
        } catch {
            self.error = "An unexpected error occurred"
            print("❌ Unexpected error: \(error)")
        }
        
        isSubmitting = false
    }
    
    /// Reset the order form
    func resetOrder() {
        selectedMain = nil
        mainQuantity = 1
        selectedDessert = nil
        dessertQuantity = 0
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        orderSuccess = false
        error = nil
    }
}

