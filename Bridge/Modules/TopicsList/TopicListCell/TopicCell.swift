//
//  TopicCell.swift
//  Bridge
//
//  Created by Jency on 04/02/26.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var topicView: UIView!
    @IBOutlet weak var topicCategory: UILabel!
    @IBOutlet weak var topicTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        // Card-style view
        topicView.layer.cornerRadius = 16
        topicView.layer.masksToBounds = false
        
        // Shadow
        topicView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        topicView.layer.shadowOpacity = 0.3
        topicView.layer.shadowOffset = CGSize(width: 0, height: 4)
        topicView.layer.shadowRadius = 8
        
        // Provide a default background color; will be overridden by configure(...)
        topicView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)
        
        // Optional: improve label styling
        topicTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        topicCategory.font = UIFont.preferredFont(forTextStyle: .subheadline)
        topicCategory.textColor = .secondaryLabel
        selectionStyle = .none
    }
    
    func configure(with topic: Topic, color: UIColor) {
        topicTitle.text = topic.title
        topicCategory.text = topic.category
        
        // Background “card” tint
        topicView.backgroundColor = color.withAlphaComponent(0.18)

    }
}
