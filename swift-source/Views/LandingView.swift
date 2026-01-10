//
//  LandingView.swift
//  KingsPrep
//
//  Landing page with app branding
//

import SwiftUI

struct LandingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "#18181b"),
                        .black,
                        .black
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 500
                )
                .opacity(0.5)
                .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    // Logo/Title
                    VStack(spacing: 16) {
                        Text("king's\nprep")
                            .font(Theme.displayFont(size: 60, weight: .bold))
                            .italic()
                            .multilineTextAlignment(.center)
                            .opacity(isAnimating ? 1 : 0)
                            .offset(y: isAnimating ? 0 : 20)
                        
                        Text("Eat Like a King")
                            .font(Theme.bodyFont(size: 12, weight: .regular))
                            .tracking(3)
                            .foregroundColor(Theme.textSecondary)
                            .opacity(isAnimating ? 1 : 0)
                    }
                    
                    Spacer()
                    
                    // View Button
                    NavigationLink(destination: MenuView()) {
                        Text("VIEW")
                            .font(Theme.bodyFont(size: 12, weight: .medium))
                            .tracking(3)
                            .foregroundColor(Theme.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Theme.surface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Theme.border, lineWidth: 1)
                            )
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 24)
                    .opacity(isAnimating ? 1 : 0)
                    
                    // Footer
                    Text("Jibraan Craig")
                        .font(Theme.bodyFont(size: 10, weight: .regular))
                        .tracking(3)
                        .foregroundColor(.white)
                        .padding(.bottom, 32)
                }
                .padding()
            }
            .foregroundColor(.white)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    isAnimating = true
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LandingView()
}

