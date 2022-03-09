//
//  ListItemCell.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import UIKit

class ListItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel                : UILabel!
    @IBOutlet weak var descLabel                 : UILabel!
    
    @IBOutlet weak var topicsView                : UICollectionView!
    @IBOutlet weak var topicsViewHeight          : NSLayoutConstraint!
    
    
    @IBOutlet weak var starLabel                 : UILabel!
    @IBOutlet weak var languageImageView         : UIImageView!
    @IBOutlet weak var languageLabel             : UILabel!
    
    
    @IBOutlet weak var licenseView               : UIView!
    @IBOutlet weak var licenseLabel              : UILabel!
    @IBOutlet weak var updateDateLabel           : UILabel!
    
    public var topics                            : [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
        self.topicsView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        if let flowLayout = self.topicsView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        self.layoutIfNeeded()
    }
    
    func setCollectionView() {
        self.topicsViewHeight.constant = 1000.0
        self.topicsView.layoutIfNeeded()
        self.topicsViewHeight.constant = self.topicsView.collectionViewLayout.collectionViewContentSize.height
        self.layoutIfNeeded()
    }
}

extension ListItemCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicItemCell", for: indexPath) as! TopicItemCell
        
        guard indexPath.row < self.topics.count else {
            return cell
        }
        
        
        cell.titleLabel.text = self.topics[indexPath.row]
        return cell
    }
}

