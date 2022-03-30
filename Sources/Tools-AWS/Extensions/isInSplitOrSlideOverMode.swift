//
//  UIApplication+SplitView.swift
//  ios-sunmobile
//
//  Created by Aylwing Olivas on 12/27/21.
//

import UIKit

// https://stackoverflow.com/questions/31367387/detect-if-app-is-running-in-slide-over-or-split-view-mode-in-ios-9
/// Bool indicating is device is `splitView` or `Slide Over` mode
var isInSplitOrSlideOverMode: Bool {
    guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return false }
    return !(window.frame.width == window.screen.bounds.width)
}
