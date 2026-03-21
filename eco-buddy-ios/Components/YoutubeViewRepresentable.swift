//
//  YoutubeViewRepresentable.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 03/10/23.
//

import Foundation
import WebKit
import SwiftUI

struct YoutubeVideoView: UIViewRepresentable {
    
    var youtubeVideoID: String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let path = "https://www.youtube.com/embed/\(youtubeVideoID)"
        guard let url = URL(string: path) else { return }
        uiView.scrollView.contentInsetAdjustmentBehavior = .never
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}
