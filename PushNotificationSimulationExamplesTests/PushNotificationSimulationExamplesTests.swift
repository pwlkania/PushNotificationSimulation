//
//  PushNotificationSimulationExamplesTests.swift
//  PushNotificationSimulationExamplesTests
//
//  Created by Pawel Kania on 20/09/2019.
//

@testable import PushNotificationSimulationExamples // Without it we do not have an access to UIApplication object
@testable import PushNotificationSimulation

import XCTest

// MARK: - PushNotificationSimulationExamplesTests

class PushNotificationSimulationExamplesTests: XCTestCase {
    
    // MARK: Properties
    
    var appDelegate: AppDelegateMock!
    var instantPushExpectation: XCTestExpectation?
    var delayedPushExpectation: XCTestExpectation?
    var instantDeviceTokenExpectation: XCTestExpectation?
    var delayedDeviceTokenExpectation: XCTestExpectation?
    
    let payload1 = "{\"aps\":{\"alert\":{\"title\":\"Game Request\",\"subtitle\":\"Five Card Draw\",\"body\":\"Bob wants to play poker\"},\"category\":\"GAME_INVITATION\"},\"gameID\":\"12345678\"}"
    let payload2 = "{\"aps\":{\"badge\":9,\"sound\":\"bingbong.aiff\"},\"messageID\":\"ABCDEFGHIJ\"}"
    let deviceToken1 = "933e3112d1eae4a1d8eb48617a265b303be28b300193b9677f0ccf52a63a5b1e"
    let deviceToken2 = "5e50fa902dcbdf6a24201f5ace289c49932fa054f7e38920c82d9dfe6a178507"
    
    // MARK: State
    
    override func setUp() {
        appDelegate = AppDelegateMock()
    }
    
    override func tearDown() {
        appDelegate.pushCallback = nil
        appDelegate = nil
        instantPushExpectation = nil
        delayedPushExpectation = nil
        instantDeviceTokenExpectation = nil
        delayedDeviceTokenExpectation = nil
    }
    
    // MARK: Tests
    
    func testInstantPush() {
        instantPushExpectation = XCTestExpectation(description: "Performs an instant push notification")
        
        XCTAssertNotNil(appDelegate)
        
        appDelegate.pushCallback = instantPushCallback
        UIApplication.shared.delegate = appDelegate
        
        XCTAssertNotNil(appDelegate.pushCallback)
        XCTAssertTrue(UIApplication.shared.delegate === appDelegate)
        
        // You can even test breakpoints. To do so, comment line below and enable near breakpoint
        sim(payload: payload1)
        
        guard let expectation = instantPushExpectation else {
            XCTFail()
            return
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDelayedPush() {
        delayedPushExpectation = XCTestExpectation(description: "Performs a delayed push notification")
        
        XCTAssertNotNil(appDelegate)
        
        appDelegate.pushCallback = delayedPushCallback
        UIApplication.shared.delegate = appDelegate
        
        XCTAssertNotNil(appDelegate.pushCallback)
        XCTAssertTrue(UIApplication.shared.delegate === appDelegate)
        
        // You can even test breakpoints. To do so, comment line below and enable near breakpoint
        sim(payload: payload2, delay: 3)
        
        guard let expectation = delayedPushExpectation else {
            XCTFail()
            return
        }
        
        wait(for: [expectation], timeout: 4)
    }
    
    func testInstantDeviceToken() {
        instantDeviceTokenExpectation = XCTestExpectation(description: "Performs an instant device token")
        
        XCTAssertNotNil(appDelegate)
        
        appDelegate.deviceTokenCallback = instantDeviceTokenCallback
        UIApplication.shared.delegate = appDelegate
        
        XCTAssertNotNil(appDelegate.deviceTokenCallback)
        XCTAssertTrue(UIApplication.shared.delegate === appDelegate)
        
        // You can even test breakpoints. To do so, comment line below and enable near breakpoint
        sim(deviceToken: deviceToken1)
        
        guard let expectation = instantDeviceTokenExpectation else {
            XCTFail()
            return
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testDelayedDeviceToken() {
        delayedDeviceTokenExpectation = XCTestExpectation(description: "Performs a delayed device token")
        
        XCTAssertNotNil(appDelegate)
        
        appDelegate.deviceTokenCallback = delayedDeviceTokenCallback
        UIApplication.shared.delegate = appDelegate
        
        XCTAssertNotNil(appDelegate.deviceTokenCallback)
        XCTAssertTrue(UIApplication.shared.delegate === appDelegate)
        
        // You can even test breakpoints. To do so, comment line below and enable near breakpoint
        sim(deviceToken: deviceToken2)
        
        guard let expectation = delayedDeviceTokenExpectation else {
            XCTFail()
            return
        }
        
        wait(for: [expectation], timeout: 4)
    }
    
    // MARK: Helpers
    
    func instantPushCallback(userInfo: [AnyHashable : Any]) {
        instantPushExpectation?.fulfill()
        
        guard
            let aps = userInfo["aps"] as? [AnyHashable : Any],
            let alert = aps["alert"] as? [AnyHashable : Any],
            let title = alert["title"] as? String,
            let subtitle = alert["subtitle"] as? String,
            let body = alert["body"] as? String,
            let category = aps["category"] as? String,
            let gameID = userInfo["gameID"] as? String
            else {
                XCTFail()
                return
        }
        XCTAssertEqual(title, "Game Request")
        XCTAssertEqual(subtitle, "Five Card Draw")
        XCTAssertEqual(body, "Bob wants to play poker")
        XCTAssertEqual(category, "GAME_INVITATION")
        XCTAssertEqual(gameID, "12345678")
    }
    
    func delayedPushCallback(userInfo: [AnyHashable : Any]) {
        delayedPushExpectation?.fulfill()
        
        guard
            let aps = userInfo["aps"] as? [AnyHashable : Any],
            let badge = aps["badge"] as? Int,
            let sound = aps["sound"] as? String
            else {
                XCTFail()
                return
        }
        
        XCTAssertEqual(badge, 9)
        XCTAssertEqual(sound, "bingbong.aiff")
    }
    
    func instantDeviceTokenCallback(deviceToken: Data) {
        instantDeviceTokenExpectation?.fulfill()
        
        let token = deviceToken.map { String(format: "%02x", $0) }.joined()
        XCTAssertEqual(token, deviceToken1)
    }
    
    func delayedDeviceTokenCallback(deviceToken: Data) {
        delayedDeviceTokenExpectation?.fulfill()
        
        let token = deviceToken.map { String(format: "%02x", $0) }.joined()
        XCTAssertEqual(token, deviceToken2)
    }
}
