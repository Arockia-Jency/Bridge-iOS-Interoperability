//
//  TopicDetailView.swift
//  Bridge
//
//  Created by Jency on 04/02/26.
//

import SwiftUI

struct TopicDetailView: View {
    // This receives the data from UIKit
    let topic: Topic
    
    // Callback to UIKit when completion toggles
    var onCompletionToggled: ((Bool) -> Void)?
    
    // Local state for interactivity
    @State private var isCompleted: Bool
    
    init(topic: Topic, onCompletionToggled: ((Bool) -> Void)? = nil) {
        self.topic = topic
        self.onCompletionToggled = onCompletionToggled
        self._isCompleted = State(initialValue: topic.isCompleted)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // 1. Header Image with Gradient
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 200)
                    
                    Image(systemName: topic.symbol)
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
                .padding(.top)

                // 2. Title & Category
                VStack(alignment: .leading, spacing: 8) {
                    Text(topic.category.uppercased())
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    
                    Text(topic.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // 3. Description
                Text(topic.description)
                    .font(.body)
                    .lineSpacing(5)
                    .foregroundColor(.primary)

                Divider()

                // 4. Interaction (Proves State Knowledge)
                Button(action: {
                    withAnimation { isCompleted.toggle() }
                    onCompletionToggled?(isCompleted)
                }) {
                    HStack {
                        Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                        Text(isCompleted ? "Completed" : "Mark as Finished")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isCompleted ? Color.green : Color.blue)
                    .cornerRadius(15)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview provider helps you design without running the simulator
struct TopicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TopicDetailView(topic: Topic(title: "Memory Management", category: "Core Swift", description: "Learn about ARC and retain cycles.", symbol: "cpu"))
    }
}
