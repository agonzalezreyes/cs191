import WatchKit
import Foundation


class MoviePlayerController: WKInterfaceController {

    @IBOutlet var movie: WKInterfaceMovie!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        movie.setPosterImage(WKImage.init(imageName: "poster"))
    }

    @IBAction func mp3PrepareAction() {
        prepareMediaPlayer(name: "music", ex: ".mp3")
    }
    
    @IBAction func mp4PrepareAction() {
        prepareMediaPlayer(name: "music", ex: ".mp4")
    }

    func prepareMediaPlayer(name: String, ex: String) {
        // WKInterfaceMovie
        let URL = Bundle.main.url(forResource: name, withExtension: ex)
        movie.setMovieURL(URL!)
    }

}
