//
//  QuizClick.swift
//  QuizClick
//
//  Created by jamonglab on 2023/11/21.
//

import Foundation
import UIKit
import WebKit

open class QuizClick : UIViewController, WKUIDelegate{
    //@IBOutlet var webView: WKWebView!
    
    private var webView: WKWebView!
    
    private let domain : String
    private let startUrl : String
    private let ukey : String
    private let ad_group : String
    private let version : Int
    private let isPrepare : Bool
    private var urlRequest : URLRequest
    
    public init(ukey:String, ad_group:String, version:Int, isPrepare:Bool){
        self.ukey = ukey
        self.ad_group = ad_group
        self.version = version
        self.isPrepare = isPrepare
        self.domain = "http://quiz.app.test.jamonglab.com"
        
        
        if(version==1){
            self.startUrl = domain+"/quiz/v1/index.html"
        }else{
            self.startUrl = domain+"/quiz/v2/index.html"
        }
        var components = URLComponents(string: startUrl)
        components?.queryItems = [
            URLQueryItem(name: "ukey", value: ukey),
            URLQueryItem(name: "ad_group", value: ad_group)
        ]
        //let url = URL(string:startUrl+"?ukey="+ukey+"&ad_group="+ad_group)
        let url = components?.url
        //print(url)
        self.urlRequest = URLRequest(url:url!)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not boon implemented")
    }
    
    
    /*
    override open func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    */
    open override func viewDidAppear(_ animated: Bool){
        super.viewDidLoad()
        view.backgroundColor = .none
        view.addSubview(webView)
        
        webView.load(self.urlRequest);
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
    }
    func setWebView(){
        let contentController = WKUserContentController()
        contentController.add(self,name:"QuizClick")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        

    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    @objc private func didDone(){
        if(isPrepare){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc private func didRefresh(){
        webView.load(self.urlRequest)
    }
    
    
    public func webViewDidClose(_ webView: WKWebView) {
        didDone()
    }
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            //print("OPEN WINDOW")
            UIApplication.shared.open(navigationAction.request.url!)
            return nil
    }
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {

            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                completionHandler()
            }))

            self.present(alertController, animated: true, completion: nil)
        }

        public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)

            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                completionHandler(true)
            }))

            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                completionHandler(false)
            }))

            self.present(alertController, animated: true, completion: nil)
        }

        public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {

            let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)

            alertController.addTextField { (textField) in
                textField.text = defaultText
            }

            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                if let text = alertController.textFields?.first?.text {
                    completionHandler(text)
                } else {
                    completionHandler(defaultText)
                }

            }))

            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in

                completionHandler(nil)

            }))

            self.present(alertController, animated: true, completion: nil)
        }

}

extension QuizClick : WKScriptMessageHandler{
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
        switch message.name{
        case "QuizClick":
            let command=message.body as? String
            if(command=="close"){
                didDone()
                
            }
            
        default:
            break
        }
    }
    
    
}
