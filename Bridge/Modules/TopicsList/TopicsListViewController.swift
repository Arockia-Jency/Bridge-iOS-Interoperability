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
    
    // Make mutable to allow updates
    var topic: [Topic] = MockData.topics
    
    // For search (optional)
    private var filtered: [Topic] = []
    private var isSearching = false
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicTableView.delegate = self
        topicTableView.dataSource = self
        register()
        
        topicTableView.separatorStyle = .none
        topicTableView.backgroundColor = .systemBackground
        topicTableView.rowHeight = 100
        topicTableView.estimatedRowHeight = 100
        topicTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        // Pull to refresh
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        topicTableView.refreshControl = refresher
        
        // Search setup (optional)
        setupSearch()
    }
    
    func register(){
        topicTableView.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
    }

    // Helper to pick a color per row or category
    private func color(for topic: Topic, at index: Int) -> UIColor {
        let palette: [UIColor] = [
            .systemBlue, .systemGreen, .systemOrange, .systemPurple, .systemTeal, .systemPink, .systemIndigo, .systemRed
        ]
        return palette[index % palette.count]
    }
    
    @objc private func refreshData() {
        // Example: shuffle to simulate “new” content and end refreshing
        topic.shuffle()
        topicTableView.reloadData()
        topicTableView.refreshControl?.endRefreshing()
    }
    
    private func setupSearch() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Topics"
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    private func currentData() -> [Topic] {
        isSearching ? filtered : topic
    }
}

extension TopicsListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentData().count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell else {
            return UITableViewCell()
        }
        
        let data = currentData()
        let currentTopic = data[indexPath.row]
        let tint = color(for: currentTopic, at: indexPath.row)
        cell.configure(with: currentTopic, color: tint)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = currentData()
        let selectedTopic = data[indexPath.row]
        
        // Build the SwiftUI view with callback
        let detailView = TopicDetailView(topic: selectedTopic) { [weak self] completed in
            guard let self = self else { return }
            
            // Find the index in the original array to update
            if self.isSearching {
                // Map back from filtered to main array by id
                if let originalIndex = self.topic.firstIndex(where: { $0.id == selectedTopic.id }) {
                    self.topic[originalIndex].isCompleted = completed
                }
                // Update filtered as well to keep UI consistent
                if let filteredIndex = self.filtered.firstIndex(where: { $0.id == selectedTopic.id }) {
                    self.filtered[filteredIndex].isCompleted = completed
                }
            } else {
                self.topic[indexPath.row].isCompleted = completed
            }
            
            DispatchQueue.main.async {
                self.topicTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        let hostingController = UIHostingController(rootView: detailView)
        
        if let nav = navigationController {
            nav.pushViewController(hostingController, animated: true)
        } else {
            print("Error: Navigation Controller is nil!")
        }
    }
}

extension TopicsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        isSearching = !text.isEmpty
        if isSearching {
            filtered = topic.filter { topic in
                topic.title.localizedCaseInsensitiveContains(text) ||
                topic.category.localizedCaseInsensitiveContains(text)
            }
        } else {
            filtered.removeAll()
        }
        topicTableView.reloadData()
    }
}
