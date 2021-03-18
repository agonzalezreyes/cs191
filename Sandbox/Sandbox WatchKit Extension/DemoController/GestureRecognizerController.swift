import UIKit
import WatchKit

class GestureRecognizerController: WKInterfaceController {
    
    @IBOutlet var tapLabel: WKInterfaceLabel!
    @IBOutlet var longPressLabel: WKInterfaceLabel!
    @IBOutlet var swipeLabel: WKInterfaceLabel!
    @IBOutlet var panLabel: WKInterfaceLabel!
    
    
    @IBAction func tapAction(_ sender: Any) {
        tapLabel.setText("Taped!")
    }
    
    @IBAction func longPressAction(_ sender: Any) {
        longPressLabel.setText("Long Pressed!")
    }
    
    @IBAction func swipeAction(_ sender: Any) {
        swipeLabel.setText("Swiped!")
    }
    
    @IBAction func panAction(_ sender: Any) {
        panLabel.setText("Panned!")
    }
}
