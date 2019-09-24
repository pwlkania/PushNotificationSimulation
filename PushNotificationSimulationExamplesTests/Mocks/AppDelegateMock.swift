//
//  AppDelegateMock.swift
//  PushNotificationSimulationExamplesTests
//
//  Created by Pawel Kania on 20/09/2019.
//

@testable import PushNotificationSimulationExamples
@testable import PushNotificationSimulation

import UIKit

// MARK: - Aliases

typealias PushCallback = ([AnyHashable : Any]) -> Void
typealias DeviceTokenCallback = (Data) -> Void

// MARK: - AppDelegateMock

class AppDelegateMock: AppDelegate {
    
    // MARK: Properties
    
    var pushCallback: PushCallback?
    var deviceTokenCallback: DeviceTokenCallback?
    
    // MARK: Overridden methods
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        pushCallback?(userInfo)
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        deviceTokenCallback?(deviceToken)
    }
}
