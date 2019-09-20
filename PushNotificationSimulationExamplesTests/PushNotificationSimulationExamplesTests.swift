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
    
    let payload1 = "{\"aps\":{\"alert\":{\"title\":\"Game Request\",\"subtitle\":\"Five Card Draw\",\"body\":\"Bob wants to play poker\"},\"category\":\"GAME_INVITATION\"},\"gameID\":\"12345678\"}"
    let payload2 = "{\"aps\":{\"badge\":9,\"sound\":\"bingbong.aiff\"},\"messageID\":\"ABCDEFGHIJ\"}"
    
    // MARK: State
    
    override func setUp() {
        appDelegate = AppDelegateMock()
    }
    
    override func tearDown() {
        appDelegate.pushCallback = nil
        appDelegate = nil
        instantPushExpectation = nil
        delayedPushExpectation = nil
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
        simPush(payload: payload1)
        
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
        simPush(payload: payload2, delay: 3)
        
        guard let expectation = delayedPushExpectation else {
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
}
