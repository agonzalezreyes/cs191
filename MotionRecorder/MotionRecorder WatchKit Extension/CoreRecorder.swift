//
//  CoreRecorder.swift
//  MotionRecorder WatchKit Extension
//
//  Created by Alejandrina Gonzalez Reyes on 2/19/21.
//

import Foundation
import CoreMotion

enum RecState {
    case idle
    case recording
}

public class CoreRecorder: ObservableObject {
    @Published var recordedMotionEvents = 0
    @Published var samplesPerSecond = 50.0
    @Published var state = RecState.idle
    
    private var motionManager = CMMotionManager()
    private var sender = Sender()
    private var firstTimestamp: TimeInterval?
    private var memoryBuffer = Array<Motion>()
    
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    public func start() {
        print("START RECORDING in queue: \(self.queue)")
        if !motionManager.isDeviceMotionAvailable {
            print("No device motion available")
            return
        }
        self.state = .recording
        motionManager.deviceMotionUpdateInterval = 1.0 / self.samplesPerSecond
        motionManager.startDeviceMotionUpdates(to: self.queue) { (deviceMotion: CMDeviceMotion?, error: Error?) in
            if let dm = deviceMotion {
                self.handle(dm)
            }
        }
    }
    
    public func stop() {
        print("STOP RECORDING")
        if state == .recording {
            motionManager.stopDeviceMotionUpdates()
            self.state = .idle
        }
        logMovement()
        sendMovement()
    }
    
    private func sendMovement(){
        let data = try? JSONEncoder().encode(memoryBuffer)
        if let data = data {
            sender.send(data)
        }
    }
    
    public func reset() {
        print("Reset recording")
        self.firstTimestamp = nil
        self.recordedMotionEvents = 0
        self.memoryBuffer.removeAll()
    }
    
    private func handle(_ deviceMotion: CMDeviceMotion) {
        if firstTimestamp == nil {
            firstTimestamp = deviceMotion.timestamp
        }
        let timediff = deviceMotion.timestamp - firstTimestamp!

        let attitude = Attitude(roll: deviceMotion.attitude.roll,
                                pitch: deviceMotion.attitude.pitch,
                                yaw: deviceMotion.attitude.yaw)

        let rotationRate = RotationRate(x: deviceMotion.rotationRate.x,
                                        y: deviceMotion.rotationRate.y,
                                        z: deviceMotion.rotationRate.z)

        let gravity = Gravity(x: deviceMotion.gravity.x,
                              y: deviceMotion.gravity.y,
                              z: deviceMotion.gravity.z)

        let acceleration = Acceleration(x: deviceMotion.userAcceleration.x,
                                        y: deviceMotion.userAcceleration.y,
                                        z: deviceMotion.userAcceleration.z)

        let motion = Motion(time: timediff,
                            attitude: attitude,
                            rotationRate: rotationRate,
                            gravity: gravity,
                            acceleration: acceleration)

       // print("Handle Device Motion for timestamp: %@", String(describing: motion.time))
        memoryBuffer.append(motion)
        DispatchQueue.main.async {
            self.recordedMotionEvents = self.memoryBuffer.count
        }
//        if let data = try? JSONEncoder().encode(motion) {
//            print("\(data)")
//            sender.send(data)
//        }
    }
    
    private func logMovement() {
        let data = try? JSONEncoder().encode(memoryBuffer)
        if let data = data {
            print(String(data: data, encoding: .utf8) ?? "")
        }
    }
}
