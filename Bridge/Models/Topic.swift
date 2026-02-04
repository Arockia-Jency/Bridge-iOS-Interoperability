//
//  Topic.swift
//  Bridge
//
//  Created by Jency on 04/02/26.
//

import Foundation

struct Topic: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let description: String
    let symbol: String // SF Symbol name
}

struct MockData {
    static let topics = [
        Topic(title: "Memory Management", category: "Core Swift", description: "Understanding ARC, weak, unowned, and how to detect retain cycles using memory graphs.", symbol: "cpu"),
        Topic(title: "Concurrency", category: "Advanced", description: "Modern Swift concurrency using async/await, Tasks, and Actors for thread safety.", symbol: "bolt.fill"),
        Topic(title: "Combine Framework", category: "Reactive", description: "Handling asynchronous events using Publishers and Subscribers.", symbol: "waveform.path.ecg"),
        Topic(title: "SwiftUI Interop", category: "Architecture", description: "How to use UIHostingController and UIViewRepresentable to bridge UIKit and SwiftUI.", symbol: "square.stack.3d.up.fill")
    ]
}
