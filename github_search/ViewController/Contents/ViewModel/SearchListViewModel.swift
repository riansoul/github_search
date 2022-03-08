//
//  SearchListViewModel.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import RxCocoa
import RxSwift


class SearchListViewModel: RxAlertSupport, RxScreenSupport, RxLoadingSupport {
    var alert   = RxAlertSupportData()
    var screen  = RxScreenSupportData()
    var loading = RxLoadingSupportData()
    
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
    
    func getColor(language : String) -> UIColor {
        
        if let dic = language_color[language] as? NSDictionary {
            let hexString = dic["color"] as? String ?? "ffffff"
            return UIColor.init(hexString: hexString)
        }
        
        
        return UIColor.init(hexString: "000000")
    }
    
}


// MARK: - API
extension SearchListViewModel {
    
    func nextListItemsData() {
        if !hasNext {
            return
        }
        
        param.page += 1
        self.getListItemsData()
    }
    
    func reloadListItemsData() {
        self.listItems.accept([])
        self.param.page = 1
        self.getListItemsData()
    }
    
    func getListItemsData(search:String) {
        self.listItems.accept([])
        self.param.search = search
        self.param.page = 1
        self.getListItemsData()
    }
    
    private func getListItemsData() {
        self.showLoading()
        KurlyAPI.shared.getSearchListInfo(param: param)
            .subscribe(onNext: { [weak self] data in
                guard let `self` = self else { return }
                self.hasNext = true
                self.response.accept(data)
                if let result = self.response.value?.items {
                    if result.count > 0 {
                        var combine = self.listItems.value
                        for value in result {
                            combine.append(value)
                        }
                        self.listItems.accept(combine)
                    }
                    self.hideLoading()
                }
            }, onError: { [weak self] error in
                guard let `self` = self else { return }
                self.hasNext = false
                self.hideLoading()
                self.showAlert(with: error.localizedDescription, retry: { [weak self] in
                                self?.getListItemsData()}, cancel: true)
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
