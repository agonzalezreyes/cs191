//
//  MotionManager.swift
//  MotionRecorder WatchKit Extension
//
//  Created by Alejandrina Gonzalez Reyes on 2/19/21.
//

import Foundation
import HealthKit
import Combine

extension MotionManager: HKWorkoutSessionDelegate {
    public func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .notStarted:
            print("Not started")
        case .prepared:
            print("Prepared")
        case .running:
            print("Running")
        case .paused:
            print("Paused")
        case .ended:
            print("Ended")
        case .stopped:
            print("Stopped")
        default:
            fatalError("Unknown state")
        }
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

public final class MotionManager : NSObject {
    private let healthStore = HKHealthStore()
    private var session: HKWorkoutSession?
    private var cancellables = Set<AnyCancellable>()
    private var isRunning : Bool? = nil
    
    private let configuration: HKWorkoutConfiguration = {
        let config = HKWorkoutConfiguration()
        config.activityType = .other
        config.locationType = .unknown
        return config
    }()
    
    func start() {
        print("Starting Motion Manager")
        isRunning = true
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
        } catch {
            print(error.localizedDescription)
        }

        session?.delegate = self
        session?.startActivity(with: Date())
    }
    
    func end() {
        print("End Motion Manager")
        if let _ = isRunning {
            session?.end()
        }
        isRunning = nil
    }
}
