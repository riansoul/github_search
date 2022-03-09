//
//  TopicItemCell.swift
//  github_search
//
//  Created by jy choi on 2022/03/09.
//

import Foundation
import UIKit

class TopicItemCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
    }

}
