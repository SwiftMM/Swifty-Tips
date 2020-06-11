//
//  NSNotification+Keyboard.swift
//  
//
//  Created by xiaobin liu on 2020/6/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

/// MARK - NSNotification
internal extension NSNotification {
    
    /// 事件
    var event: KeyboardEvent {
        switch self.name {
        case UIResponder.keyboardWillShowNotification:
            return .willShow
        case UIResponder.keyboardDidShowNotification:
            return .didShow
        case UIResponder.keyboardWillHideNotification:
            return .willHide
        case UIResponder.keyboardDidHideNotification:
            return .didHide
        case UIResponder.keyboardWillChangeFrameNotification:
            return .willChangeFrame
        case UIResponder.keyboardDidChangeFrameNotification:
            return .didChangeFrame
        default:
            return .unknown
        }
    }
    
    /// 时间间隔
    var timeInterval: TimeInterval? {
        guard let value = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return nil }
        return TimeInterval(truncating: value)
    }
    
    
    /// 动画曲线
    var animationCurve: UIView.AnimationCurve? {
        guard let index = (userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue else { return nil }
        guard index >= 0 && index <= 3 else { return .linear }
        return UIView.AnimationCurve.init(rawValue: index) ?? .linear
    }
    
    /// 动画选项
    var animationOptions: UIView.AnimationOptions {
        guard let curve = animationCurve else { return [] }
        switch curve {
        case .easeIn:
            return .curveEaseIn
        case .easeOut:
            return .curveEaseOut
        case .easeInOut:
            return .curveEaseInOut
        case .linear:
            return .curveLinear
        @unknown default:
            return .curveLinear
        }
    }
    
    
    /// 开始位置
    var startFrame: CGRect? {
        return (userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
    }
    
    /// 结束位置
    var endFrame: CGRect? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    }
    
    /// 是否当前应用
    var isForCurrentApp: Bool? {
        return (userInfo?[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue
    }
    
}




