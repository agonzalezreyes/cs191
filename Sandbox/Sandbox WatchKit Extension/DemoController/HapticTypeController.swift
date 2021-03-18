import UIKit
import WatchKit

class HapticTypeController: WKInterfaceController {
    
    @IBOutlet var typeLabel: WKInterfaceLabel!
    
    let typeNameArray = ["Notification", "DirectionUp", "DirectionDown", "Success", "Failure", "Retry", "Start", "Stop", "Click"]
    let hapticTypeArray: [WKHapticType] = [.notification, .directionUp, .directionDown, .success, .failure, .retry, .start, .stop, .click]
    var flag = 0

    @IBAction func tapticEnginePlay() {
        let index = flag % 9
        typeLabel.setText("This is " + typeNameArray[index])
        WKInterfaceDevice.current().play(hapticTypeArray[index])
        flag = flag + 1
    }
}
