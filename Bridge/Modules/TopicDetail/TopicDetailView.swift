//
//  TopicDetailView.swift
//  Bridge
//
//  Created by Jency on 04/02/26.
//

import SwiftUI
struct TopicDetailView: View {
    let topic: Topic
    @State private var animateIn = false

    var body: some View {
        ZStack {
            // Background subtle gradient
            Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // 1. HERO SECTION
                    ZStack {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(LinearGradient(colors: [.blue.opacity(0.7), .purple.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 250)
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                        
                        Image(systemName: topic.symbol)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .scaleEffect(animateIn ? 1.0 : 0.5) // Animation!
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)

                    // 2. TEXT CONTENT
                    VStack(alignment: .leading, spacing: 15) {
                        Text(topic.category.uppercased())
                            .font(.system(.caption, design: .rounded))
                            .fontWeight(.bold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                            .foregroundColor(.blue)
                        
                        Text(topic.title)
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                        
                        Text(topic.description)
                            .font(.system(.body, design: .rounded))
                            .lineSpacing(8)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 25)
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                animateIn = true
            }
        }
    }
}
