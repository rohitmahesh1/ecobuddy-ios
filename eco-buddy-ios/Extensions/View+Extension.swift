//
//  View+Extension.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 18/10/23.
//

import SwiftUI

extension View {
    func onBackSwipe(perform action: @escaping () -> Void) -> some View {
        gesture(
            DragGesture()
                .onEnded({ value in
                    if value.startLocation.x < 50 && value.translation.width > 80 {
                        action()
                    }
                })
        )
    }
}
