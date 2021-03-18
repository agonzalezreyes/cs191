import UIKit
import WatchKit
import CoreMotion

class MotionActivityController: WKInterfaceController {
    
    @IBOutlet var activityLabel: WKInterfaceLabel!
    let activityManager = CMMotionActivityManager()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let state = CMMotionActivityManager.authorizationStatus()
        if state != .authorized {
            print("Please Authorize In Your iPhone App")
            return
        }
        
        if CMMotionActivityManager.isActivityAvailable() {
            
            activityManager.startActivityUpdates(to: OperationQueue.main) { (activity) in
                if activity?.stationary == true {
                    self.activityLabel.setText("Stationary")
                } else if activity?.walking == true {
                    self.activityLabel.setText("Walking")
                } else if activity?.running == true {
                    self.activityLabel.setText("Running")
                } else if activity?.automotive == true {
                    self.activityLabel.setText("Automotive")
                } else if activity?.cycling == true {
                    self.activityLabel.setText("Cycling")
                } else if activity?.unknown == true {
                    self.activityLabel.setText("Unknown")
                }
            }
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        activityManager.stopActivityUpdates()
    }
}
