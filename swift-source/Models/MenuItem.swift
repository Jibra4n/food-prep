//
//  MenuItem.swift
//  KingsPrep
//
//  Data model for menu items
//

import Foundation

struct MenuItem: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Int // Price in cents (e.g., 650 = £6.50)
    let category: String
    let imageUrl: String
    let nutritionalInfo: String?
    
    var formattedPrice: String {
        String(format: "£%.2f", Double(price) / 100.0)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, price, category
        case imageUrl = "image_url"
        case nutritionalInfo = "nutritional_info"
    }
}

enum Category: String, CaseIterable {
    case main = "main"
    case dessert = "dessert"
    
    var displayName: String {
        switch self {
        case .main: return "Menu Mains"
        case .dessert: return "Menu Desserts"
        }
    }
}

