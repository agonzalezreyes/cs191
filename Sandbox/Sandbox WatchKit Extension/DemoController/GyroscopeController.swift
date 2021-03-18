import UIKit
import WatchKit
import CoreMotion

class GyroscopeController: WKInterfaceController {
    
    @IBOutlet var XLabel: WKInterfaceLabel!
    @IBOutlet var YLabel: WKInterfaceLabel!
    @IBOutlet var ZLabel: WKInterfaceLabel!
    
    lazy var motionManager: CMMotionManager = {
        let manager = CMMotionManager()
        manager.gyroUpdateInterval = 0.1
        return manager
    }()
    
    
    override func willActivate() {
        super.willActivate()
        
        if motionManager.isGyroAvailable {
            
            motionManager.startGyroUpdates(to: OperationQueue.main) { (data, error) in
                if let rotationRate = data?.rotationRate {
                    self.XLabel.setText(String(format: "%.2f", rotationRate.x))
                    self.YLabel.setText(String(format: "%.2f", rotationRate.y))
                    self.ZLabel.setText(String(format: "%.2f", rotationRate.z))
                }
            }
        } else {
            XLabel.setText("Not Available")
            YLabel.setText("Not Available")
            ZLabel.setText("Not Available")
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
        motionManager.stopGyroUpdates()
    }
}
