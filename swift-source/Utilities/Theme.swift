//
//  Theme.swift
//  KingsPrep
//
//  Centralized design system (colors, fonts, spacing)
//

import SwiftUI

struct Theme {
    // MARK: - Colors
    
    static let background = Color.black
    static let surface = Color(hex: "#18181b") // zinc-900
    static let surfaceLight = Color(hex: "#27272a") // zinc-800
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: "#a1a1aa") // zinc-400
    static let textTertiary = Color(hex: "#71717a") // zinc-500
    static let border = Color.white.opacity(0.05)
    static let borderLight = Color.white.opacity(0.1)
    
    // MARK: - Typography
    
    /// Display font (Playfair Display) - for titles and headings
    static func displayFont(size: CGFloat, weight: Font.Weight = .bold) -> Font {
        // Note: You need to add PlayfairDisplay font to your project
        // Fallback to system font if custom font not available
        return .custom("PlayfairDisplay-Bold", size: size)
            .weight(weight)
    }
    
    /// Body font (DM Sans) - for general text
    static func bodyFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // Note: You need to add DMSans font to your project
        // Fallback to system font if custom font not available
        return .custom("DMSans-Regular", size: size)
            .weight(weight)
    }
    
    /// Mono font (JetBrains Mono) - for prices and codes
    static func monoFont(size: CGFloat) -> Font {
        // Note: You need to add JetBrainsMono font to your project
        // Fallback to system font if custom font not available
        return .custom("JetBrainsMono-Regular", size: size)
    }
    
    // MARK: - Spacing
    
    static let spacing = Spacing()
    
    struct Spacing {
        let xs: CGFloat = 4
        let sm: CGFloat = 8
        let md: CGFloat = 16
        let lg: CGFloat = 24
        let xl: CGFloat = 32
        let xxl: CGFloat = 48
    }
    
    // MARK: - Corner Radius
    
    static let cornerRadius = CornerRadius()
    
    struct CornerRadius {
        let sm: CGFloat = 8
        let md: CGFloat = 12
        let lg: CGFloat = 16
        let xl: CGFloat = 24
    }
}

// MARK: - Color Extension for Hex

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

