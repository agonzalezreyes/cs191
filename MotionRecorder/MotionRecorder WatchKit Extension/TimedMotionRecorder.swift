//
//  TimedMotionRecorder.swift
//  MotionRecorder WatchKit Extension
//
//  Created by Alejandrina Gonzalez Reyes on 2/19/21.
//

import Foundation

public final class TimedMotionRecorder: CoreRecorder {
    private var startAfter, stopAfter : DispatchTimeInterval
    private var motionManager = MotionManager()
    
    init(startAfter: DispatchTimeInterval, recordFor: DispatchTimeInterval){
        self.startAfter = startAfter
        self.stopAfter = recordFor
        super.init()
    }
    
    public override func start() {
        self.reset()
        motionManager.start()
        print("Dispatching start in \(String(describing: self.startAfter))")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + startAfter) {
            super.start()
            if self.state == .recording {
                print("Dispatching stop in \(String(describing: self.stopAfter))")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.stopAfter) {
                    self.stop()
                    self.motionManager.end()
                }
            } else {
                self.motionManager.end()
            }
        }
    }
}
