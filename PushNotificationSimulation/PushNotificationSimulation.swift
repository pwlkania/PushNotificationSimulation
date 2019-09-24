//
//  PushNotificationSimulation.swift
//  PushNotificationSimulation
//
//  Created by Pawel Kania on 19/09/2019.
//

import UIKit
import UserNotifications

// MARK: - PushNotificationSimulation

public protocol PushNotificationSimulation { }

// MARK: - PushNotificationSimulation where UIApplicationDelegate

public extension PushNotificationSimulation where Self: UIApplicationDelegate {
    
    // MARK: Functions
    
    /// Calls `...didReceiveRemoteNotification...` function on behalf of `UIApplication.shared.delegate` object
    /// - Parameter payload: Content of push notification
    func send(payload: String) {
        
        debugPrint("Sending a simulated push notification...")
        debugPrint(payload)
        
        guard let userInfo = payload.toDictionary() else {
            debugPrint("Unable to send simulated push notification!")
            return
        }
        
        application?(UIApplication.shared, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: { _ in })
        
        debugPrint("Simulated push notification sent!")
    }
    
    /// Calls `...didRegisterForRemoteNotificationsWithDeviceToken...` function on behalf of `UIApplication.shared.delegate` object
    /// - Parameter deviceToken: Device token in string format
    func send(deviceToken: String) {
        
        debugPrint("Sending a simulated device token...")
        debugPrint(deviceToken)
        
        application?(UIApplication.shared, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken.hexDecodedData())
        
        debugPrint("Simulated device token sent!")
    }
}

// MARK: - Global functions

/// Global function which sends simulated push notification
///
/// - Parameters:
///   - payload: Content of push notification
///   - delay: Delay after which push notification will be send
public func sim(payload: String, delay: TimeInterval = 0) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        guard let appDelegate = UIApplication.shared.delegate as? PushNotificationSimulation & UIApplicationDelegate else { return }
        appDelegate.send(payload: payload)
    }
}

/// Global function which sends simulated push notification device token
/// - Parameter deviceToken: Device token in string format
/// - Parameter delay: Delay after which device token will be send
public func sim(deviceToken: String, delay: TimeInterval = 0) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        guard let appDelegate = UIApplication.shared.delegate as? PushNotificationSimulation & UIApplicationDelegate else { return }
        appDelegate.send(deviceToken: deviceToken)
    }
}

// MARK: - String extensions

fileprivate extension String {
    
    // MARK: Functions
    
    /// Converts a JSON string dictionary
    func toDictionary() -> [AnyHashable: Any]? {
        guard let data = data(using: .utf8), let json = try? JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any] else { return nil }
        return json
    }
    
    /// A data representation of the hexadecimal bytes in this string.
    /// (Solution found on https://stackoverflow.com/a/52600783)
    func hexDecodedData() -> Data {
        // Get the UTF8 characters of this string
        let chars = Array(utf8)
        
        // Keep the bytes in an UInt8 array and later convert it to Data
        var bytes = [UInt8]()
        bytes.reserveCapacity(count / 2)
        
        // It is a lot faster to use a lookup map instead of strtoul
        let map: [UInt8] = [
            0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, // 01234567
            0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 89:;<=>?
            0x00, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x00, // @ABCDEFG
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  // HIJKLMNO
        ]
        
        // Grab two characters at a time, map them and turn it into a byte
        for i in stride(from: 0, to: count, by: 2) {
            let index1 = Int(chars[i] & 0x1F ^ 0x10)
            let index2 = Int(chars[i + 1] & 0x1F ^ 0x10)
            bytes.append(map[index1] << 4 | map[index2])
        }
        
        return Data(bytes)
    }
}
