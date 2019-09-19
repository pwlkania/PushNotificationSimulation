//
//  PushNotificationSimulation.swift
//  PushNotificationSimulation
//
//  Created by Pawel Kania on 19/09/2019.
//

import UIKit

#if DEBUG

// MARK: - PushNotificationSimulation

public protocol PushNotificationSimulation {
    
    // MARK: Properties
    
    /// App object
    var app: UIApplication? { get set }
}

// MARK: - PushNotificationSimulation where UIApplicationDelegate

public extension PushNotificationSimulation where Self: UIApplicationDelegate {
    
    // MARK: Functions
    
    /// Calls `... didReceiveRemoteNotification ...` function on behalf of `UIApplication.shared.delegate` object
    ///
    /// - Parameter payload: Content of push notification
    func send(payload: String) {
        
        debugPrint("Sending a simulated push notification...")
        debugPrint(payload)
        
        func convertToDictionary(_ string: String) -> [AnyHashable: Any]? {
            guard let data = string.data(using: .utf8), let json = try? JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any] else { return nil }
            return json
        }
        
        guard let userInfo = convertToDictionary(payload), let app = app else {
            debugPrint("Unable to send simulated push notification!")
            return
        }
        
        application?(app, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: { _ in })
        
        debugPrint("Simulated push notification sent!")
    }
}

// MARK: - Global functions

/// Global function which sends simulated push notification
///
/// - Parameters:
///   - payload: Content of push notification
///   - delay: Delay after which push notification will be send
public func simPush(payload: String, delay: TimeInterval = 0) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        guard let appDelegate = UIApplication.shared.delegate as? PushNotificationSimulation & UIApplicationDelegate else { return }
        appDelegate.send(payload: payload)
    }
}

#endif
