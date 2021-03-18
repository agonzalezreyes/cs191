import UIKit
import WatchKit

class MediaPlayerController: WKInterfaceController {
    
    
    @IBAction func mp3PlayAction() {
        playMedia(name: "music", ex: ".mp3")
    }
    
    @IBAction func mp4PlayAction() {
        playMedia(name: "music", ex: ".mp4")
    }
    
    func playMedia(name: String, ex: String) {
        // MediaPlayer
        let URL = Bundle.main.url(forResource: name, withExtension: ex)
        let option = [WKMediaPlayerControllerOptionsAutoplayKey: true]

        presentMediaPlayerController(with: URL!, options: option) { (isEnd, endTime, error) in
            if error == nil {
                print("endTime=\(endTime)");
            } else {
                print("error=\(error!)")
            }
        }
    }

}
