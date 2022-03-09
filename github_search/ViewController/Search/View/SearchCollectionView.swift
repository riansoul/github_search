//
//  SearchCollectionView.swift
//  github_search
//
//  Created by jy choi on 2022/03/09.
//

import UIKit

class SearchCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
