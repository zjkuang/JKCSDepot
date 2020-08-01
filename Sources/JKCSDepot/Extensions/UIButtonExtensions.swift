//
//  File.swift
//  
//
//  Created by Zhengqian Kuang on 2020-08-01.
//

import UIKit

public extension UIButton {
    private static var _onTapDelegate = [String:(() -> ())]()
    private var onTapDelegate: (() -> ())? {
        get {
            let key = keyForInstance()
            return UIButton._onTapDelegate[key]
        }
        set(newValue) {
            let key = keyForInstance()
            if let value = newValue {
                UIButton._onTapDelegate[key] = value
            }
            else {
                UIButton._onTapDelegate.removeValue(forKey: key)
            }
        }
    }
    
    private func keyForInstance() -> String {
        let key = String(format: "%p", unsafeBitCast(self, to: Int.self))
        return key
    }
    
    @discardableResult
    func onTap(onTap: @escaping () -> ()) -> Self {
        onTapDelegate = onTap
        addTarget(self, action: #selector(onTouchDown), for: .touchDown)
        addTarget(self, action: #selector(onTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(onTouchUpOutside), for: .touchUpOutside)
        return self
    }
    
    @objc private func onTouchUpInside() {
        // self.alpha = 1
        onTapDelegate?()
    }
    
    @objc private func onTouchUpOutside() {
        // self.alpha = 1
    }
    
    @objc private func onTouchDown() {
        // self.alpha = 0.2
    }
}
