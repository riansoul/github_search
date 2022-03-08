//
//  SearchListView.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SearchListView : UIViewController, LoadingProtocol {
    
    

    static var `default`: SearchListView {
        return UIStoryboard("Main").identifier("SearchList") as! SearchListView
    }
    
    @IBOutlet public weak var tableView             : UITableView!
    @IBOutlet public weak var searchView            : UISearchBar!
    
    var loading                 : LoadingViewController?
    private var refreshControl  : UIRefreshControl!
    private var viewModel       : SearchListViewModel!
    private var isReload        : Bool = false
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
        bindRx()
    }
    
    func initialize() {
        self.viewModel = SearchListViewModel.init()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.backgroundColor = UIColor.white
        self.refreshControl.addTarget(self, action:#selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

// MARK: - RefreshControl
extension SearchListView {
    func searchTextError() {
        let confirm = AlertButtonData.init(text: alert_confirm) {
            self.searchView.becomeFirstResponder()
        }

        let alert = AlertData.init(message: text_length_error,
                                   buttons: [confirm])

        self.viewModel.showAlert(with: alert)
    }

}

// MARK: - RefreshControl
extension SearchListView {
    @objc func handleRefresh(_ refreshControl: AnyObject) {
        if self.searchView.text!.count == 0 {
            self.searchTextError()
            return
        }
        self.viewModel.reloadListItemsData()
    }
    
    @objc func endRefresh() {
        self.refreshControl.endRefreshing()
    }
}

// MARK: - scrollView
extension SearchListView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        if contentHeight == 0 {
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        let height = scrollView.frame.height
        
        
        if offsetY > (contentHeight - height) {
            if self.isReload && self.viewModel.hasNext {
                self.viewModel.nextListItemsData()
                self.isReload = false
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension SearchListView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SearchListView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getTableRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = self.viewModel.getTableData(at: indexPath) else {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ListItem", for:indexPath) as! ListItemCell
        cell.titleLabel.text = item.full_name
        cell.descLabel.text = item.description
        cell.starLabel.text = item.stargazers_count?.count()
        cell.languageLabel.text = item.language
        cell.languageImageView.backgroundColor = self.viewModel.getColor(language: item.language ?? "ffffff")
        
        
        let license = item.license?.name ?? ""        
        cell.licenseLabel.isHidden = license.count == 0 ? true : false
        cell.licenseView.isHidden = license.count == 0 ? true : false
        cell.licenseLabel.text = license
        
        cell.updateDateLabel.text = item.updated_at
        
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchListView : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text!.count == 0 {
            self.searchTextError()
            return
        }
        
        self.viewModel.getListItemsData(search: searchBar.text ?? "")
    }
}

// MARK: - RxBindProtocol
extension SearchListView : RxBindProtocol {
    func bindRx() {
        bind(viewModel, bag: disposeBag)
        guard let `viewModel` = viewModel else { return }
        
        let input = SearchListViewModel.Input(
            
        )
        
        let output = viewModel.transform(input: input)
        
        output.listItems
            .observeOn(MainScheduler.instance)
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(onNext: { data in
                self.tableView.reloadData()
                self.isReload = true
                self.perform(#selector(self.endRefresh), with:nil, afterDelay: 0.3)
            })
            .disposed(by: disposeBag)
    }
}
