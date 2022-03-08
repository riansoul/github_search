//
//  LoadingViewController.swift
//  github_search
//
//  Created by jy choi on 2022/03/08.
//

import UIKit

class LoadingViewController: UIViewController {

    static var `default`: LoadingViewController {
        return UIStoryboard("Common").identifier("Loading") as! LoadingViewController
    }
    
    @IBOutlet weak var loadingIndicator    : UIActivityIndicatorView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadingIndicator.stopAnimating()
    }
    
    open override var shouldAutorotate: Bool {
        if  UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        
        return false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if  UIDevice.current.userInterfaceIdiom == .pad {
            return .all
        }
        
        return .portrait
    }
    
    
}

