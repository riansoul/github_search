//
//  SearchContentWebView.swift
//  github_search
//
//  Created by jy choi on 2022/03/09.
//

import Foundation
import UIKit

class SearchContentWebView : UIViewController {
    
    static func `default`(with: String) -> SearchContentWebView {
        let viewController = UIStoryboard("Main").identifier("SearchContent") as! SearchContentWebView
        viewController.urlStr = with
        return viewController
    }
    
    @IBOutlet weak var searchWebView     : SearchWebView!
    private var urlStr                   : String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()

    }
    
    func initialize() {
        self.searchWebView.initialize(urlStr: urlStr)
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
