//
//  KeyboardNotification.swift
//  
//
//  Created by xiaobin liu on 2020/6/11.
//  Copyright © 2020 CocoaPods. All rights reserved.
//


import UIKit


/// MARK - 键盘通知
public struct KeyboardNotification {
    
    // MARK: - Properties
    
    /// 事件
    public let event: KeyboardEvent
    
    /// 动画时间
    public let timeInterval: TimeInterval
    
    /// 动画可选项
    public let animationOptions: UIView.AnimationOptions
    
    /// iPad支持分屏应用，这表明通知是否针对当前应用
    public let isForCurrentApp: Bool
    
    /// 开始位置
    public var startFrame: CGRect
    
    /// 结束为止
    public var endFrame: CGRect
    
    /// Requires that the `NSNotification` is based on a `UIKeyboard...` event
    ///
    /// - Parameter notification: `KeyboardNotification`
    public init?(from notification: NSNotification) {
        guard notification.event != .unknown else { return nil }
        self.event = notification.event
        self.timeInterval = notification.timeInterval ?? 0.25
        self.animationOptions = notification.animationOptions
        self.isForCurrentApp = notification.isForCurrentApp ?? true
        self.startFrame = notification.startFrame ?? .zero
        self.endFrame = notification.endFrame ?? .zero
    }
    
}



