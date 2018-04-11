//
//  ViewController.swift
//  WebView
//
//  Created by Antonio Prado on 4/11/18.
//  Copyright © 2018 Antonio Prado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate{
    
    var webView: UIWebView?
    var background: UIView?
    var activityIndicator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        background = UIView(frame: view.frame)
        background?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:50, height:50))
        activityIndicator?.center = background!.center
        activityIndicator?.activityIndicatorViewStyle = .whiteLarge
        activityIndicator?.color = .purple
        background?.addSubview(activityIndicator!)
        
        webView = UIWebView(frame: CGRect(x:0, y:50, width:view.frame.width, height: view.frame.height-50))
        webView?.delegate = self
        
        //URL
        if let url = URL(string: "http://www.eluniversal.com.mx/") {
            let request = URLRequest(url: url)
            webView?.loadRequest(request)
        }
        view?.addSubview(webView!)
        
        //Toolbar
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        toolBar.barTintColor = .purple
        toolBar.tintColor = .white
        
        //Buttons
        let backB = UIBarButtonItem(title: "Atrás", style: .plain, target: self, action: #selector(backPressed))
        let forwardB = UIBarButtonItem(title: "Adelante", style: .plain, target: self, action: #selector(forwardPressed))
        
        toolBar.items = [backB,forwardB]
        view.addSubview(toolBar)
    }
    
    @objc func backPressed () {
        
        if webView!.canGoBack{
            webView?.goBack()
        }
    }
    
    @objc func forwardPressed (){
        if webView!.canGoForward{
            webView?.goForward()
        }
    }
    
    //MARK:  wbViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print("should start load")
        view.addSubview(background!)
        activityIndicator?.startAnimating()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return true
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Did start load")
        print("Scheme: \(webView.request?.url?.scheme ?? "No especificado")")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Did finish load")
        activityIndicator?.stopAnimating()
        background?.removeFromSuperview()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Did fail load with error: \(error.localizedDescription)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

