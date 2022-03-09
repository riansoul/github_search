//
//  SearchColloectionView.swift
//  github_search
//
//  Created by Geondae Baek on 2022/03/09.
//

import Foundation
import UIKit
class SearchColloectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width , height: 10000)
        self.layoutIfNeeded()
        let newCellSize = CGSize(width: self.collectionViewLayout.collectionViewContentSize.width, height: self.collectionViewLayout.collectionViewContentSize.height)
            return newCellSize
        }
}
