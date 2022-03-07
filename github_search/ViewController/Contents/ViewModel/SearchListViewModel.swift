//
//  SearchListViewModel.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import RxCocoa
import RxSwift


class SearchListViewModel: RxScreenSupport {
    var screen  = RxScreenSupportData()
    
    public  let response     = BehaviorRelay<Response?>(value: nil)
    public  let listItems    = BehaviorRelay<[item]>(value: [])
    
    private var param        : searchParam = searchParam.init(search: "", page: 1)
    public var hasNext       : Bool = true
    
    
    private let disposeBag  = DisposeBag()
    
    init() {

    }
}

// MARK: - Get items Data
extension SearchListViewModel {
    
    func getTotalCount() -> Int {
        return self.response.value?.total_count ?? 0
    }
    
    func getTableRowCount() -> Int {
        return self.listItems.value.count
    }
        
    func getTableData(at : IndexPath) -> item? {
        guard at.row < self.getTableRowCount() else { return nil }
        return self.listItems.value[at.row]
    }
    
}


// MARK: - API
extension SearchListViewModel {
    
    func getListItemsData(search:String) {
        self.param.search = search
        self.getListItemsData()
    }
    
    private func getListItemsData() {
        KurlyAPI.shared.getSearchListInfo(param: param)
            .subscribe(onNext: { [weak self] data in
                guard let `self` = self else { return }
                self.response.accept(data)
                if let result = self.response.value?.items {
                    if result.count > 0 {
                        var combine = self.listItems.value
                        for value in result {
                            combine.append(value)
                        }
                        self.listItems.accept(combine)
                    }
                }
            }, onError: { [weak self] error in
                guard let `self` = self else { return }
                self.hasNext = false
            }).disposed(by: disposeBag)
    }
}


// MARK: - RX
extension SearchListViewModel : ViewModelTypeProtocol {
    
    struct Input {
        
    }
    
    struct Output {
        let listItems      : Observable<[item]>
        
    }
    
    func transform(input: SearchListViewModel.Input) -> SearchListViewModel.Output {        
        let listItems      = self.listItems.map { $0 }
        return Output(
            listItems      :   listItems
        )
    }
}
