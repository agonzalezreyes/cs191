import UIKit
import WatchKit

class TextVoiceInputController: WKInterfaceController {
    
    @IBOutlet var contentLabel: WKInterfaceLabel!
    

    @IBAction func textVoiceInputAction() {
        presentTextInputController(withSuggestions: ["Hello!", "When are you free?", "Yes."], allowedInputMode: .plain) { (inputText) in
            if let stringArr = inputText {
                self.contentLabel.setText(stringArr[0] as? String)
            }
        }
    }
    
}
