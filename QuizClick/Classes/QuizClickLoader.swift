//
//  QuizClickLoader.swift
//  QuizClick
//
//  Created by anytoon on 2023/11/21.
//

import Foundation
import UIKit

open class QuizClickLoader {
    private let ukey: String
    private let ad_group: String
    private let version: Int
    
    public init(ukey: String, ad_group: String, version: Int) {
        self.ukey = ukey
        self.ad_group = ad_group
        self.version = version
    }
    
    open func loadPush() -> UIViewController {
        let quizClick = QuizClick(ukey: ukey, ad_group: ad_group, version: version, isPrepare: false)
        let nav = UINavigationController(rootViewController: quizClick)
        nav.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
    open func load() -> UINavigationController {
        let quizClick = QuizClick(ukey: ukey, ad_group: ad_group, version: version, isPrepare: true)
        let nav = UINavigationController(rootViewController: quizClick)
        nav.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        nav.setNavigationBarHidden(true, animated: false)
        return nav
    }
}
