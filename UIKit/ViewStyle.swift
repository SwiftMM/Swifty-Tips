// reference: https://felginep.github.io/2019-02-19/uiview-styling-with-functions

import UIKit

infix operator +

func +<T>(lhs: ViewStyle<T>, rhs: ViewStyle<T>) -> ViewStyle<T> {
    return lhs.compose(with: rhs)
}

struct ViewStyle<T> {
    let style: (T) -> Void
}

extension ViewStyle {
    
    func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T> {
            self.style($0)
            style.style($0)
        }
    }
}

extension ViewStyle where T: UIButton {
    
    static var filled: ViewStyle<UIButton> {
        return ViewStyle<UIButton> {
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .red
        }
    }
    
    static var rounded: ViewStyle<UIButton> {
        return ViewStyle<UIButton> {
            $0.layer.cornerRadius = 4.0
        }
    }
    
    static var roundedAndFilled: ViewStyle<UIButton> {
        return rounded.compose(with: filled)
    }
}

protocol Stylable {
    init()
}

extension UIView: Stylable {}

extension Stylable {
    
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
    
    func apply(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}

let style: ViewStyle = .filled + .rounded
let button = UIButton(style: style)
button.setTitle("My Button", for: .normal)
button.sizeToFit()
