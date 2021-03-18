import UIKit
import WatchKit

class OpenURLController: WKInterfaceController {

    
    @IBAction func openTelAction() {
        let url = URL(string: "tel://10086")!
        WKExtension.shared().openSystemURL(url)
    }
    
    @IBAction func openMessageAction() {
        let url = URL(string: "sms://10010")!
        WKExtension.shared().openSystemURL(url)
    }
    
}
