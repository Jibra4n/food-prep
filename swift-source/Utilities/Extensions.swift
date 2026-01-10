//
//  Extensions.swift
//  KingsPrep
//
//  Useful Swift extensions
//

import SwiftUI

// MARK: - View Extensions

extension View {
    /// Add a tracking (letter-spacing) modifier
    func tracking(_ amount: CGFloat) -> some View {
        self.kerning(amount)
    }
}

// MARK: - Date Extensions

extension Date {
    /// Format date as "Tomorrow" or "Day, Mon DD"
    func formatForPickup() -> String {
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())
        
        if calendar.isDate(self, inSameDayAs: tomorrow ?? Date()) {
            return "Tomorrow"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMM d"
            return formatter.string(from: self)
        }
    }
    
    /// Get an array of dates for the next N days
    static func nextDays(_ count: Int) -> [Date] {
        let calendar = Calendar.current
        return (1...count).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: Date())
        }
    }
}

// MARK: - String Extensions

extension String {
    /// Localized string (for future internationalization)
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

