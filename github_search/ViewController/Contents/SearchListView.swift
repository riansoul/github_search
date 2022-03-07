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

class SearchListView : UIViewController {

    static var `default`: SearchListView {
        return UIStoryboard("Main").identifier("SearchList") as! SearchListView
    }
    
    @IBOutlet public weak var tableView             : UITableView!
    @IBOutlet public weak var searchView            : UISearchBar!
    
    private var viewModel       : SearchListViewModel!
    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
        bindRx()
    }
    
    func initialize() {
        self.viewModel = SearchListViewModel.init()        
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

// MARK: - UITableViewDelegate
extension SearchListView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SearchListView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ListItem", for:indexPath)
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchListView : UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
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
            })
            .disposed(by: disposeBag)
    }
}
