//
//  Receiver.swift
//  MotionRecorder
//
//  Created by Alejandrina Gonzalez Reyes on 2/19/21.
//

import Foundation
import WatchConnectivity

class Receiver: NSObject, ObservableObject {
    private var session = WCSession.default
    private var appStore: AppStore

    init(appStore: AppStore) {
        self.appStore = appStore
        super.init()
        if (WCSession.isSupported()) {
            session.delegate = self
            session.activate()
        }
    }
}

extension Receiver: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage")
        if let jsonData = message["jsonData"] as? Data {
            appStore.appendMotion(motion: try! JSONDecoder().decode(Motion.self, from: jsonData))
        }
    }
}

struct AppState {
    var receivedMotions = 0
    var motions = [Motion]()
}

enum Action {
    case increment
    case appendMotion(Motion)
}

func reduce(_ appState: inout AppState, _ action: Action) {
    switch action {
    case .appendMotion(let motion):
        appState.motions.append(motion)
    case .increment:
        appState.receivedMotions += 1
    }
}

typealias reducer = (_ appState: inout AppState, _ action: Action) -> Void

class AppStore: ObservableObject {
    @Published private(set) var state: AppState
    var reduce: reducer

    init(appState: AppState, reduce: @escaping reducer) {
        self.state = appState
        self.reduce = reduce
    }

    func appendMotion(motion: Motion) {
        DispatchQueue.main.async {
            self.reduce(&self.state, .appendMotion(motion))
            self.reduce(&self.state, .increment)
        }
    }

    func appendMotion(motions: [Motion]) {
        motions.forEach { self.appendMotion(motion: $0) }
    }
}
