//
//  OrderView.swift
//  KingsPrep
//
//  Order form page
//

import SwiftUI

struct OrderView: View {
    @StateObject private var orderViewModel = OrderViewModel()
    @StateObject private var menuViewModel = MenuViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            if orderViewModel.orderSuccess {
                OrderSuccessView()
            } else {
                orderFormView
            }
        }
        .task {
            await menuViewModel.loadMenuItems()
        }
    }
    
    private var orderFormView: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Main Selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("MAIN MEAL")
                        .font(Theme.bodyFont(size: 12, weight: .bold))
                        .tracking(2)
                        .foregroundColor(Theme.textTertiary)
                    
                    HStack(spacing: 16) {
                        Menu {
                            ForEach(menuViewModel.mains) { item in
                                Button(item.name) {
                                    orderViewModel.selectedMain = item
                                }
                            }
                        } label: {
                            HStack {
                                Text(orderViewModel.selectedMain?.name ?? "Select Main...")
                                    .foregroundColor(orderViewModel.selectedMain == nil ? Theme.textSecondary : .white)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Theme.textSecondary)
                            }
                            .font(Theme.bodyFont(size: 14))
                            .padding()
                            .frame(height: 48)
                            .background(Theme.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Theme.border, lineWidth: 1)
                            )
                            .cornerRadius(12)
                        }
                        
                        Menu {
                            ForEach(1...5, id: \.self) { qty in
                                Button("\(qty)") {
                                    orderViewModel.mainQuantity = qty
                                }
                            }
                        } label: {
                            HStack {
                                Text("\(orderViewModel.mainQuantity)")
                                    .foregroundColor(.white)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Theme.textSecondary)
                            }
                            .font(Theme.bodyFont(size: 14))
                            .frame(width: 96, height: 48)
                            .background(Theme.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Theme.border, lineWidth: 1)
                            )
                            .cornerRadius(12)
                        }
                    }
                }
                
                // Dessert Selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("DESSERT (OPTIONAL)")
                        .font(Theme.bodyFont(size: 12, weight: .bold))
                        .tracking(2)
                        .foregroundColor(Theme.textTertiary)
                    
                    HStack(spacing: 16) {
                        Menu {
                            Button("None") {
                                orderViewModel.selectedDessert = nil
                                orderViewModel.dessertQuantity = 0
                            }
                            ForEach(menuViewModel.desserts) { item in
                                Button(item.name) {
                                    orderViewModel.selectedDessert = item
                                    if orderViewModel.dessertQuantity == 0 {
                                        orderViewModel.dessertQuantity = 1
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(orderViewModel.selectedDessert?.name ?? "Select Dessert...")
                                    .foregroundColor(orderViewModel.selectedDessert == nil ? Theme.textSecondary : .white)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Theme.textSecondary)
                            }
                            .font(Theme.bodyFont(size: 14))
                            .padding()
                            .frame(height: 48)
                            .background(Theme.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Theme.border, lineWidth: 1)
                            )
                            .cornerRadius(12)
                        }
                        
                        Menu {
                            ForEach(0...5, id: \.self) { qty in
                                Button("\(qty)") {
                                    orderViewModel.dessertQuantity = qty
                                }
                            }
                        } label: {
                            HStack {
                                Text("\(orderViewModel.dessertQuantity)")
                                    .foregroundColor(.white)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Theme.textSecondary)
                            }
                            .font(Theme.bodyFont(size: 14))
                            .frame(width: 96, height: 48)
                            .background(Theme.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Theme.border, lineWidth: 1)
                            )
                            .cornerRadius(12)
                        }
                        .disabled(orderViewModel.selectedDessert == nil)
                        .opacity(orderViewModel.selectedDessert == nil ? 0.3 : 1)
                    }
                }
                
                // Date Picker
                VStack(alignment: .leading, spacing: 16) {
                    Text("WHEN")
                        .font(Theme.bodyFont(size: 12, weight: .bold))
                        .tracking(2)
                        .foregroundColor(Theme.textTertiary)
                    
                    DatePicker(
                        "",
                        selection: $orderViewModel.selectedDate,
                        in: Date()...,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .accentColor(.white)
                    .colorScheme(.dark)
                    .frame(height: 48)
                    .padding(.horizontal)
                    .background(Theme.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Theme.border, lineWidth: 1)
                    )
                    .cornerRadius(12)
                }
                
                // Total
                Divider()
                    .background(Theme.border)
                    .padding(.vertical, 8)
                
                HStack {
                    Text("ORDER TOTAL")
                        .font(Theme.bodyFont(size: 12, weight: .bold))
                        .tracking(2)
                        .foregroundColor(Theme.textTertiary)
                    
                    Spacer()
                    
                    Text(orderViewModel.formattedTotal)
                        .font(Theme.displayFont(size: 30, weight: .bold))
                        .foregroundColor(.white)
                }
                
                // Error message
                if let error = orderViewModel.error {
                    Text(error)
                        .font(Theme.bodyFont(size: 12))
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
        .background(Theme.background.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("order")
                    .font(Theme.displayFont(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
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
                
                Button {
                    Task {
                        await orderViewModel.submitOrder()
                    }
                } label: {
                    if orderViewModel.isSubmitting {
                        ProgressView()
                            .tint(.black)
                    } else {
                        Text("ORDER")
                            .font(Theme.bodyFont(size: 14, weight: .medium))
                            .tracking(2)
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(orderViewModel.canSubmit ? Color.white : Color.gray.opacity(0.5))
                .cornerRadius(12)
                .disabled(!orderViewModel.canSubmit || orderViewModel.isSubmitting)
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
}

struct OrderSuccessView: View {
    @State private var scale: CGFloat = 0
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                    .scaleEffect(scale)
                
                VStack(spacing: 8) {
                    Text("Order Confirmed")
                        .font(Theme.displayFont(size: 30))
                        .foregroundColor(.white)
                    
                    Text("See you at pickup!")
                        .font(Theme.bodyFont(size: 14))
                        .foregroundColor(Theme.textSecondary)
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                scale = 1
            }
            
            // Auto-dismiss after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        OrderView()
    }
}

