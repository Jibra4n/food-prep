//
//  MenuView.swift
//  KingsPrep
//
//  Menu listing page showing mains and desserts
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = MenuViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 48) {
                    if viewModel.isLoading {
                        loadingView
                    } else if let error = viewModel.error {
                        errorView(error)
                    } else {
                        // Mains Section
                        MenuSection(
                            title: "Menu Mains",
                            items: viewModel.mains
                        )
                        
                        // Desserts Section
                        MenuSection(
                            title: "Menu Desserts",
                            items: viewModel.desserts
                        )
                    }
                }
                .padding()
                .padding(.bottom, 100)
            }
            
            // Floating Action Button
            NavigationLink(destination: OrderView()) {
                Text("START ORDER")
                    .font(Theme.bodyFont(size: 12, weight: .medium))
                    .tracking(3)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .white.opacity(0.1), radius: 20)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("menu")
                    .font(Theme.displayFont(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .task {
            await viewModel.loadMenuItems()
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .tint(.white)
            Text("Loading menu...")
                .font(Theme.bodyFont(size: 14))
                .foregroundColor(Theme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 100)
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("Error Loading Menu")
                .font(Theme.displayFont(size: 20))
                .foregroundColor(.white)
            
            Text(message)
                .font(Theme.bodyFont(size: 14))
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
            
            Button("Try Again") {
                Task {
                    await viewModel.loadMenuItems()
                }
            }
            .font(Theme.bodyFont(size: 14, weight: .medium))
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Theme.surface)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.top, 50)
    }
}

struct MenuSection: View {
    let title: String
    let items: [MenuItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(title)
                .font(Theme.bodyFont(size: 12, weight: .bold))
                .tracking(2)
                .foregroundColor(Theme.textTertiary)
                .padding(.leading, 4)
            
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                MenuItemCard(item: item, index: index)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MenuView()
    }
}

