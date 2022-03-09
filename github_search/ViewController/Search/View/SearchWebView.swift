//
//  SearchWebView.swift
//  github_search
//
//  Created by jy choi on 2022/03/09.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import WebKit

// MARK: - SearchWebView
public class SearchWebView: UIView {

    private var webView                        : WKWebView!
    private var webBottomConstraint            : NSLayoutConstraint?
    
    func initialize(urlStr : String)  {
        
        let config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.default()
        config.processPool = WKProcessPool.init()
        if #available(iOS 13.0, *) {
            config.defaultWebpagePreferences.preferredContentMode = .mobile
        }
        
        self.webView = WKWebView(frame: CGRect.zero, configuration: config)
        self.webView.backgroundColor = UIColor.init(r: 229.5, g: 229.5, b: 229.5, a: 1)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.allowsLinkPreview = false
        
        self.webView.clipsToBounds = false
        self.webView.scrollView.clipsToBounds = false
        self.webView.scrollView.bounces = true
        self.webView.allowsBackForwardNavigationGestures = false
        
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        self.insertSubview(self.webView, at: 0);
        
        self.webView.scrollView.contentInsetAdjustmentBehavior = .never

        self.webView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.webView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.webView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        self.webBottomConstraint = self.webView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:0)
        self.webBottomConstraint?.isActive = true

        let urlRequest = URLRequest(url:URL.init(string: urlStr)!)
        self.webView.load(urlRequest)
    }
    
    
    deinit {
        print("deinit wkwebview")
        self.webView.stopLoading()
        self.webView.navigationDelegate = nil
        self.webView.uiDelegate = nil
    }
    
    func deinitalize()  {
        self.webView.stopLoading()
        self.webView.navigationDelegate = nil
        self.webView.uiDelegate = nil
    }
    
}

// MARK: - WKScriptMessageHandler
extension SearchWebView: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

    }
}

// MARK: - WKNavigationDelegate
extension SearchWebView: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {

    }
    
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request: URLRequest? = navigationAction.request
        let url: URL = (request?.url!)!
        print("\nRequest Url : ",url)
       
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
 
}


// MARK: - WKUIDelegate
extension SearchWebView: WKUIDelegate {
    
    public func webViewDidClose(_ webView: WKWebView) {
        self.webView.navigationDelegate = nil
        self.webView.uiDelegate = nil
        self.webView.scrollView.delegate = nil
    }

    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
    }
    
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
    }
}


