import UIKit
import WatchKit
import CoreMotion

class AccelerometerController: WKInterfaceController {
    
    @IBOutlet var XLabel: WKInterfaceLabel!
    @IBOutlet var YLabel: WKInterfaceLabel!
    @IBOutlet var ZLabel: WKInterfaceLabel!
    
    lazy var motionManager: CMMotionManager = {
        let manager = CMMotionManager()
        manager.accelerometerUpdateInterval = 0.1
        return manager
    }()
    
    
    override func willActivate() {
        super.willActivate()
        
        if motionManager.isAccelerometerAvailable {
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                if let acceleration = data?.acceleration {
                    self.XLabel.setText(String(format: "%.2f", acceleration.x))
                    self.YLabel.setText(String(format: "%.2f", acceleration.y))
                    self.ZLabel.setText(String(format: "%.2f", acceleration.z))
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
        
        motionManager.stopAccelerometerUpdates()
    }
}
