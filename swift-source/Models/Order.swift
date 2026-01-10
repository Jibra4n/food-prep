//
//  Order.swift
//  KingsPrep
//
//  Data models for orders
//

import Foundation

struct Order: Codable {
    let id: Int?
    let mainItemId: Int
    let mainQuantity: Int
    let dessertItemId: Int?
    let dessertQuantity: Int
    let pickupDate: String
    let totalPrice: Int
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case mainItemId = "main_item_id"
        case mainQuantity = "main_quantity"
        case dessertItemId = "dessert_item_id"
        case dessertQuantity = "dessert_quantity"
        case pickupDate = "pickup_date"
        case totalPrice = "total_price"
        case createdAt = "created_at"
    }
}

struct CreateOrderRequest: Codable {
    let mainItemId: Int
    let mainQuantity: Int
    let dessertItemId: Int?
    let dessertQuantity: Int
    let pickupDate: String
    let totalPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case mainItemId = "mainItemId"
        case mainQuantity = "mainQuantity"
        case dessertItemId = "dessertItemId"
        case dessertQuantity = "dessertQuantity"
        case pickupDate, totalPrice
    }
}

