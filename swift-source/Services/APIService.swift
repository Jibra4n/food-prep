//
//  APIService.swift
//  KingsPrep
//
//  Service for making API calls to the backend
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
    case serverError(Int)
}

class APIService {
    static let shared = APIService()
    
    // MARK: - Configuration
    // ⚠️ IMPORTANT: Replace with your actual backend URL
    private let baseURL = "http://localhost:5000" // Change this to your backend URL
    
    private init() {}
    
    // MARK: - Menu Endpoints
    
    /// Fetch all menu items
    func fetchMenuItems() async throws -> [MenuItem] {
        guard let url = URL(string: "\(baseURL)/api/menu") else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            let menuItems = try decoder.decode([MenuItem].self, from: data)
            return menuItems
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    /// Fetch a specific menu item by ID
    func fetchMenuItem(id: Int) async throws -> MenuItem {
        guard let url = URL(string: "\(baseURL)/api/menu/\(id)") else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            let menuItem = try decoder.decode(MenuItem.self, from: data)
            return menuItem
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    // MARK: - Order Endpoints
    
    /// Create a new order
    func createOrder(_ orderRequest: CreateOrderRequest) async throws -> Order {
        guard let url = URL(string: "\(baseURL)/api/orders") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(orderRequest)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            let order = try decoder.decode(Order.self, from: data)
            return order
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
}

