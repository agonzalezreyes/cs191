//
//  Motion.swift
//  MotionRecorder
//
//  Created by Alejandrina Gonzalez Reyes on 2/19/21.
//

import Foundation

struct Attitude: Codable {
    var roll, pitch, yaw: Double
}

struct RotationRate: Codable {
    var x, y, z: Double
}

struct Gravity: Codable {
    var x, y, z: Double
}

struct Acceleration: Codable {
    var x, y, z: Double
}

struct Motion: Codable {
    var time: TimeInterval
    var attitude: Attitude
    var rotationRate: RotationRate
    var gravity: Gravity
    var acceleration: Acceleration
}

enum Direction: String {
    case inwardRot = "InwardRot";
    case outwardRot = "OutwardRot";
    case left = "Left";
    case right = "Right";
    case away = "Away";
    case closer = "Closer"
    static var all = [Direction.inwardRot, .outwardRot, .left, .right, .away, .closer]
}
