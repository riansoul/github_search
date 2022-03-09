//
//  SearchTableHeaderView.swift
//  github_search
//
//  Created by jy choi on 2022/03/09.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class SearchTableHeaderView: UITableViewHeaderFooterView {
 
    @IBOutlet public weak var countLabel  : UILabel!
    
    private var viewModel : SearchListViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
    }
    
    func initHederView(viewModel:SearchListViewModel) {
        self.viewModel = viewModel
        self.settingCountLabel()
    }
}


extension SearchTableHeaderView {
    func settingCountLabel() {
        self.countLabel.text = self.viewModel.getTotalCountText()
    }
}
