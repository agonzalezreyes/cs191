import WatchKit
import Foundation


class InlineMoviePlayerController: WKInterfaceController {
    
    @IBOutlet var inlineMovie: WKInterfaceInlineMovie!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        inlineMovie.setPosterImage(WKImage.init(imageName: "poster"))
        inlineMovie.setLoops(true)
        inlineMovie.setAutoplays(false)
    }
    
    @IBAction func mp3PrepareAction() {
        prepareMediaPlayer(name: "music", ex: ".mp3")
    }
    
    @IBAction func mp4PrepareAction() {
        prepareMediaPlayer(name: "music", ex: ".mp4")
    }

    @IBAction func play() {
        inlineMovie.play()
    }
    
    @IBAction func pause() {
        inlineMovie.pause()
    }
    
    @IBAction func playFromBeginning() {
        inlineMovie.playFromBeginning()
    }
    
    func prepareMediaPlayer(name: String, ex: String) {
        // WKInterfaceMovie
        let URL = Bundle.main.url(forResource: name, withExtension: ex)
        inlineMovie.setMovieURL(URL!)
    }

}
