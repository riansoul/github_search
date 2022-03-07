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
    
    
    
    @IBOutlet weak var starLabel                 : UILabel!
    @IBOutlet weak var languageImageView         : UIImageView!
    @IBOutlet weak var languageLabel             : UILabel!
    
    
    @IBOutlet weak var licenseView               : UIView!
    @IBOutlet weak var licenseLabel              : UILabel!
    @IBOutlet weak var updateDateLabel           : UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
    }

}

extension ListItemCell : UICollectionViewDelegate {
    
}

extension ListItemCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicsCell", for: indexPath)
        
        return cell
    }
}

