import UIKit
import WatchKit

class AudioFilePlayerController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

    }
    
    @IBAction func play() {
        let URL = Bundle.main.url(forResource: "music", withExtension: "mp3")
        
        let audioasset = WKAudioFileAsset.init(url: URL!)
        let audioitem = WKAudioFilePlayerItem.init(asset: audioasset)
        let audioplayer = WKAudioFilePlayer.init(playerItem: audioitem)
        audioplayer.play()
    }
}
