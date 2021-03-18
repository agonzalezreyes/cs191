//
//  MotionDataModel.swift
//  MotionRecorder
//
//  Created by Alejandrina Gonzalez Reyes on 2/22/21.
//

import Foundation

class MotionDataModel: NSObject {
    
    private var motionData = [[String:[Motion]]]()

    override init() {}
    
    func appendMotion(direction: String, motions: [Motion]) {
        motionData.append([direction:motions])
    }
}
