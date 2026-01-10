//
//  ItemDetailView.swift
//  KingsPrep
//
//  Detailed view of a single menu item
//

import SwiftUI

struct ItemDetailView: View {
    let itemId: Int
    @State private var item: MenuItem?
    @State private var isLoading = true
    @State private var error: String?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            if isLoading {
                loadingView
            } else if let error = error {
                errorView(error)
            } else if let item = item {
                contentView(item: item)
            }
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadItem()
        }
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .tint(.white)
            Text("Loading...")
                .font(Theme.bodyFont(size: 14))
                .foregroundColor(Theme.textSecondary)
                .padding(.top, 8)
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("Error")
                .font(Theme.displayFont(size: 20))
                .foregroundColor(.white)
            
            Text(message)
                .font(Theme.bodyFont(size: 14))
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
            
            Button("Try Again") {
                Task {
                    await loadItem()
                }
            }
            .font(Theme.bodyFont(size: 14, weight: .medium))
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Theme.surface)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
    
    private func contentView(item: MenuItem) -> some View {
        ScrollView {
            VStack(spacing: 32) {
                // Hero Image
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: item.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Theme.surface)
                            .aspectRatio(1, contentMode: .fill)
                            .overlay(
                                ProgressView()
                                    .tint(.white)
                            )
                    }
                    .clipped()
                    
                    // Gradient Overlay
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.8)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    
                    // Title & Price
                    HStack(alignment: .bottom) {
                        Text(item.name)
                            .font(Theme.displayFont(size: 30, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(item.formattedPrice)
                            .font(Theme.monoFont(size: 20))
                    }
                    .foregroundColor(.white)
                    .padding(24)
                }
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Theme.border, lineWidth: 1)
                )
                
                // Ingredients
                VStack(alignment: .leading, spacing: 8) {
                    Text("INGREDIENTS")
                        .font(Theme.bodyFont(size: 12, weight: .bold))
                        .tracking(2)
                        .foregroundColor(Theme.textTertiary)
                    
                    Text(item.description)
                        .font(Theme.bodyFont(size: 14, weight: .light))
                        .foregroundColor(Theme.textSecondary)
                        .lineSpacing(6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Nutritional Info
                VStack(alignment: .leading, spacing: 8) {
                    Text("NUTRITIONAL INFO")
                        .font(Theme.bodyFont(size: 12, weight: .bold))
                        .tracking(2)
                        .foregroundColor(Theme.textTertiary)
                    
                    Text(item.nutritionalInfo ?? "No nutritional info available.")
                        .font(Theme.monoFont(size: 12))
                        .foregroundColor(Theme.textSecondary)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Theme.surface.opacity(0.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Theme.border, lineWidth: 1)
                        )
                        .cornerRadius(12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .padding(.bottom, 100)
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 16) {
                Button {
                    dismiss()
                } label: {
                    Text("BACK")
                        .font(Theme.bodyFont(size: 14, weight: .medium))
                        .tracking(2)
                        .foregroundColor(Theme.textSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Theme.surface)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Theme.border, lineWidth: 1)
                        )
                        .cornerRadius(12)
                }
                
                NavigationLink(destination: OrderView()) {
                    Text("ORDER")
                        .font(Theme.bodyFont(size: 14, weight: .medium))
                        .tracking(2)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [.black, .black, .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .ignoresSafeArea()
            )
        }
    }
    
    private func loadItem() async {
        isLoading = true
        error = nil
        
        do {
            item = try await APIService.shared.fetchMenuItem(id: itemId)
        } catch {
            self.error = error.localizedDescription
            print("❌ Error loading item: \(error)")
        }
        
        isLoading = false
    }
}

#Preview {
    NavigationStack {
        ItemDetailView(itemId: 1)
    }
}

