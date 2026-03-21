//
//  Lottie+Representable.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 03/10/23.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let animationName: String
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationName)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        
        // Set the frame dimensions here
        let screenBounds = UIScreen.main.bounds
        animationView.frame = CGRect(x: 0, y: 0, width: screenBounds.width, height: 224)
        return animationView
    }
}
