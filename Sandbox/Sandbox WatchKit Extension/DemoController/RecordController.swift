import UIKit
import WatchKit

class RecordController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.textVoiceInput()
        }
    }
    
    func textVoiceInput() {
        let option2: [String: Any] = [WKAudioRecorderControllerOptionsActionTitleKey: "Options",
                                       WKAudioRecorderControllerOptionsAutorecordKey: true,
                                       WKAudioRecorderControllerOptionsMaximumDurationKey: 30]

        // Use App Group URL
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupKeyRecord)
        let newUrl = url!.appendingPathComponent("record.wav")
        
        presentAudioRecorderController(withOutputURL:newUrl , preset: .narrowBandSpeech, options: option2) { (didSave, error) in
            if error == nil {
                print("didSave=\(didSave)");
            } else {
                print("error=\(error!)")
            }
        }
    }
    
}
