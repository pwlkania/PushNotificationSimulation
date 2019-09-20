//
//  ViewController.swift
//  PushNotificationSimulationExamples
//
//  Created by Pawel Kania on 19/09/2019.
//

import UIKit
import PushNotificationSimulation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        // This breakpoint is disabled, because it has an influence on the unit tests!
        super.viewDidLoad()
        
        // You can also use global function `simPush(...)` in the code, however it's safer to stick to the breakpoints
        // simPush(payload: "{\"aps\":{\"alert\":{\"title\":\"Game Request\",\"subtitle\":\"Five Card Draw\",\"body\":\"Bob wants to play poker\"},\"category\":\"GAME_INVITATION\"},\"gameID\":\"12345678\"}", delay: 3)
    }
}
