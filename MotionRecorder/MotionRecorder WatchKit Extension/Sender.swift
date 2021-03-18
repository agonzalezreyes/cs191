//
//  Sender.swift
//  MotionRecorder WatchKit Extension
//
//  Created by Alejandrina Gonzalez Reyes on 2/19/21.
//

import Foundation
import WatchConnectivity

class Sender: NSObject {
    private var session = WCSession.default

    override init() {
        super.init()
        if (WCSession.isSupported()) {
            session.delegate = self
            session.activate()
        }
    }

    func send(_ jsonData: Data) {
        let data = ["jsonData":jsonData as Any]
        session.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }

    func send(_ text: String) {
        let data = ["message":text as Any]
        session.sendMessage(data, replyHandler: nil) { error in
            print("%@", error.localizedDescription)
        }
    }
}

extension Sender: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}
