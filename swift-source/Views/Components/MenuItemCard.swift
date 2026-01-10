//
//  MenuItemCard.swift
//  KingsPrep
//
//  Reusable menu item card component
//

import SwiftUI

struct MenuItemCard: View {
    let item: MenuItem
    let index: Int
    @State private var isVisible = false
    
    var body: some View {
        NavigationLink(destination: ItemDetailView(itemId: item.id)) {
            VStack(alignment: .leading, spacing: 0) {
                // Image
                AsyncImage(url: URL(string: item.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Theme.surface)
                            .aspectRatio(4/3, contentMode: .fill)
                            .overlay(
                                ProgressView()
                                    .tint(.white)
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(4/3, contentMode: .fill)
                    case .failure:
                        Rectangle()
                            .fill(Theme.surface)
                            .aspectRatio(4/3, contentMode: .fill)
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(Theme.textSecondary)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
                .clipped()
                
                // Content
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        Text(item.name)
                            .font(Theme.displayFont(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(item.formattedPrice)
                            .font(Theme.monoFont(size: 14))
                            .foregroundColor(Theme.textSecondary)
                    }
                    
                    HStack {
                        Text("SHOW MORE")
                            .font(Theme.bodyFont(size: 12, weight: .medium))
                            .tracking(2)
                            .foregroundColor(Theme.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Theme.border, lineWidth: 1)
                            )
                            .cornerRadius(8)
                    }
                }
                .padding(24)
            }
            .background(Theme.surface.opacity(0.5))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Theme.border, lineWidth: 1)
            )
            .cornerRadius(24)
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(isVisible ? 1 : 0)
        .offset(y: isVisible ? 0 : 20)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(Double(index) * 0.1)) {
                isVisible = true
            }
        }
    }
}

#Preview {
    MenuItemCard(
        item: MenuItem(
            id: 1,
            name: "Grilled Chicken",
            description: "Chicken, rice, vegetables",
            price: 850,
            category: "main",
            imageUrl: "https://images.unsplash.com/photo-1598103442097-8b74394b95c6",
            nutritionalInfo: "Calories: 450\nProtein: 35g"
        ),
        index: 0
    )
    .padding()
    .background(Color.black)
}

