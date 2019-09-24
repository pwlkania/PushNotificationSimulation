//
//  AppDelegate.swift
//  PushNotificationSimulationExamples
//
//  Created by Pawel Kania on 19/09/2019.
//

import UIKit
import PushNotificationSimulation

#if DEBUG
extension AppDelegate: PushNotificationSimulation { }
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("Push notification: \(userInfo)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02x", $0) }.joined()
        debugPrint("Device Token: \(token)")
    }
}
