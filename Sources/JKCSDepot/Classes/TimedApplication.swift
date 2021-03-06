//
//  File.swift
//  
//
//  Created by Zhengqian Kuang on 2020-06-27.
//

import Foundation
import UIKit

public class TimedApplication: UIApplication {
    public static var userActivityTimeoutInSeconds: TimeInterval = 0
    private var idleTimer: Timer?
    
    private override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        resetIdleTimer()
    }
    
    override public func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if let touches = event.allTouches,
            touches.any({ $0.phase == UITouch.Phase.began }){
            userDidBecomeActive()
        }
    }
    
    private func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        if Self.userActivityTimeoutInSeconds > 0.01 {
            idleTimer = Timer.scheduledTimer(timeInterval: Self.userActivityTimeoutInSeconds, target: self, selector: #selector(idleTimerExceeded), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func idleTimerExceeded() {
        NotificationCenter.default.post(name: .userDidBecomeInactive, object: self, userInfo: ["idleTimeInterval": TimedApplication.userActivityTimeoutInSeconds])
    }
    
    @objc internal func userDidBecomeActive() {
        NotificationCenter.default.post(name: .userDidBecomeActive, object: self)
        resetIdleTimer()
    }
}
