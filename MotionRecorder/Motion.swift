//
//  Motion.swift
//  MotionRecorder
//
//  Created by Alejandrina Gonzalez Reyes on 2/19/21.
//

import Foundation

public struct Attitude: Codable {
    var roll, pitch, yaw: Double
}

public struct RotationRate: Codable {
    var x, y, z: Double
}

public struct Gravity: Codable {
    var x, y, z: Double
}

public struct Acceleration: Codable {
    var x, y, z: Double
}

public struct Motion: Codable {
    var time: TimeInterval
    var attitude: Attitude
    var rotationRate: RotationRate
    var gravity: Gravity
    var acceleration: Acceleration
}

public enum Direction: String {
    case inwardRot = "InwardRot";
    case outwardRot = "OutwardRot";
    case left = "Left";
    case right = "Right";
    case away = "Away";
    case closer = "Closer"
    static var all = [Direction.inwardRot, .outwardRot, .left, .right, .away, .closer]
}

public let motionCSVFileName = "motion.csv"
public let motionCSVHeader = "time, attitudeRoll, attitudePitch, attitudeYaw, rotationRateX, rotationRateY, rotationRateZ, gravityX, gravityY, gravityZ, accelerationX, accelerationY, accelerationZ, direction\n"

public func createNewMotionCVSFile(override: Bool){
    if override || read(fromDocumentsWithFileName: motionCSVFileName) == nil {
        print("createNewMotionCVSFile(): Creating new file.")
        save(text: motionCSVHeader, toDirectory: documentDirectory(), withFileName: motionCSVFileName)
        if let data = read(fromDocumentsWithFileName: motionCSVFileName) {
            print(data)
        }
    } else {
        print("createNewMotionCVSFile(): File already exists.")
        printMotionCVSFilePath()
    }
}

public func printMotionCVSFile() {
    guard let existingData = read(fromDocumentsWithFileName: motionCSVFileName) else {
        return
    }
    print(existingData)
}

public func printMotionCVSFilePath() {
    print("\(documentDirectory())" + "/" + "\(motionCSVFileName)")
}

public func parseMotionDataToCVS(direction: String, motionArray motions: [Motion]) {
    print("DIRECTION OF DATA: \(direction)")
    var data = ""
    for motion in motions {
        var newDataPoints = ""
        
        let time = motion.time
        newDataPoints += "\(time), "
        
        let attitude = motion.attitude
        newDataPoints += "\(attitude.roll), \(attitude.pitch), \(attitude.yaw), "
        
        let rotationRate = motion.rotationRate
        newDataPoints += "\(rotationRate.x), \(rotationRate.y), \(rotationRate.z), "

        let gravity = motion.gravity
        newDataPoints += "\(gravity.x), \(gravity.y), \(gravity.z), "

        let acceleration = motion.acceleration
        newDataPoints += "\(acceleration.x), \(acceleration.y), \(acceleration.z), "
        
        newDataPoints += "\(direction)\n"

        data += newDataPoints
    }
    saveToExistingFile(text: data, withFileName: motionCSVFileName)
}
