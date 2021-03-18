import UIKit
import WatchKit

class ProgressController: WKInterfaceController {

    @IBOutlet var progressGroup: WKInterfaceGroup!
    @IBOutlet var picker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        var images: [UIImage]! = []
        var pickerItems: [WKPickerItem]! = []
        for i in 0...100 {
            let name = "activity-\(i)"
            images.append(UIImage(named: name)!)
            
            let pickerItem = WKPickerItem()
            pickerItem.title = "No.\(i)"
            pickerItems.append(pickerItem)
        }
        
        let progressImages = UIImage.animatedImage(with: images, duration: 0.0)
        progressGroup.setBackgroundImage(progressImages)
        picker.setCoordinatedAnimations([progressGroup])
        picker.setItems(pickerItems)
    }
    
}
