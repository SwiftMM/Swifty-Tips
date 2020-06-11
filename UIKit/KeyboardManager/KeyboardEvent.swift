//
//  KeyboardEvent.swift
//
//
//  Created by xiaobin liu on 2020/6/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

/// MARK - KeyboardEvent
public enum KeyboardEvent {
    
    /// Event raised by UIKit's `.UIKeyboardWillShow`.
    case willShow
    
    /// Event raised by UIKit's `.UIKeyboardDidShow`.
    case didShow
    
    /// Event raised by UIKit's `.UIKeyboardWillShow`.
    case willHide
    
    /// Event raised by UIKit's `.UIKeyboardDidHide`.
    case didHide
    
    /// Event raised by UIKit's `.UIKeyboardWillChangeFrame`.
    case willChangeFrame
    
    /// Event raised by UIKit's `.UIKeyboardDidChangeFrame`.
    case didChangeFrame
    
    /// Non-keyboard based event raised by UIKit
    case unknown
    
}
