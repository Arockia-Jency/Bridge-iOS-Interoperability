//
//  ViewController.swift
//  Bridge
//
//  Created by Jency on 04/02/26.
//

import UIKit
import SwiftUI

class TopicsListViewController: UIViewController {
    
    @IBOutlet weak var topicTableView: UITableView!
    
    let topic = MockData.topics

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Tell the table view to talk to THIS controller
        topicTableView.delegate = self
        topicTableView.dataSource = self
        
        register()
        
    }
    
    func register(){
        topicTableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
    }

    // Helper to pick a color per row or category
    private func color(for topic: Topic, at index: Int) -> UIColor {
        // You can base this on category instead of index if you prefer
        let palette: [UIColor] = [
            .systemBlue, .systemGreen, .systemOrange, .systemPurple, .systemTeal, .systemPink, .systemIndigo, .systemRed
        ]
        return palette[index % palette.count]
    }
}

extension TopicsListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topic.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. Cast the cell to your custom TopicCell class
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell else {
            return UITableViewCell()
        }
        
        let currentTopic = topic[indexPath.row]
        let tint = color(for: currentTopic, at: indexPath.row)
        cell.configure(with: currentTopic, color: tint)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) tapped!")
        
        let topics = topic[indexPath.row]
        let detailView = TopicDetailView(topic: topics)
        let hostingController = UIHostingController(rootView: detailView)
        
        if let nav = navigationController {
            nav.pushViewController(hostingController, animated: true)
        } else {
            print("Error: Navigation Controller is nil!") // If this prints, fix SceneDelegate.
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

