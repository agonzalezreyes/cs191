import UIKit
import WatchKit
import CoreMotion

class MagnetometerController: WKInterfaceController {
    
    @IBOutlet var XLabel: WKInterfaceLabel!
    @IBOutlet var YLabel: WKInterfaceLabel!
    @IBOutlet var ZLabel: WKInterfaceLabel!
    
    lazy var motionManager: CMMotionManager = {
        let manager = CMMotionManager()
        manager.magnetometerUpdateInterval = 0.1
        return manager
    }()
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if motionManager.isMagnetometerAvailable {
            
            motionManager.startMagnetometerUpdates(to: OperationQueue.main) { (data, error) in
                if let magneticField = data?.magneticField {
                    self.XLabel.setText(String(format: "%.2f", magneticField.x))
                    self.YLabel.setText(String(format: "%.2f", magneticField.y))
                    self.ZLabel.setText(String(format: "%.2f", magneticField.z))
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
        
        motionManager.stopMagnetometerUpdates()
    }
}
