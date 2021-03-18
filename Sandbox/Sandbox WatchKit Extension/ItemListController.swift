import WatchKit
import Foundation


class ItemListController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    private var currIndex = 0
    private var myTimer : Timer!
    var shaker:WatchShaker = WatchShaker(shakeSensibility: .shakeSensibilitySoft, delay: 0.2)

    let dataArray = {
        return [
            
            ["image": "item_type_0", "title": "Menu Action And Controller Life Cycle" , "ID": "MenusController"],
            ["image": "item_type_1", "title": "Gesture Recongnizer" , "ID": "GestureRecongnizerController"],
            ["image": "item_type_2", "title": "Alert Style" , "ID": "AlertController"],
            // Picker
            ["image": "item_type_3", "title": "Picker Styles" , "ID": "PickerController"],
            ["image": "item_type_4", "title": "Picker With Animated Images" , "ID": "ProgressController"],
            // Animation/Gif
            ["image": "item_type_5", "title": "Animations And Gif Play" , "ID": "AnimationController"],
            // Media
            ["image": "item_type_6", "title": "Audio File Player" , "ID": "AudioFilePlayerController"],
            ["image": "item_type_6", "title": "Text And Voice Input" , "ID": "TextVoiceInputController"],
            ["image": "item_type_7", "title": "Media Player" , "ID": "MediaPlayerController"],
            ["image": "item_type_8", "title": "Record Audio" , "ID": "RecordController"],
            // Application Switch
            ["image": "item_type_9", "title": "Open URL" , "ID": "OpenURLController"],
            // connectivity between watch to iPhone
            ["image": "item_type_10", "title": "Interaction: iPhone & Watch" , "ID": "MessageController"],
            // Hardware measurement
            ["image": "item_type_11", "title": "Accelerometer Monitor" , "ID": "AccelerometerController"],
            ["image": "item_type_12", "title": "Gyroscope Monitor" , "ID": "GyroscopeController"],
            ["image": "item_type_13", "title": "Magnetometer Monitor" , "ID": "MagnetometerController"],
            ["image": "item_type_14", "title": "Device Motion" , "ID": "DeviceMotionController"],
            ["image": "item_type_15", "title": "Haptic Types" , "ID": "HapticTypeController"],
            // Location/Map
            ["image": "item_type_16", "title": "Location" , "ID": "LocationController"],
            ["image": "item_type_17", "title": "Map" , "ID": "MapController"],
            // Health/Activity
            ["image": "item_type_18", "title": "Motion Activity" , "ID": "MotionActivityController"],
            ["image": "item_type_19", "title": "Pedometer" , "ID": "PedometerController"],
            ["image": "item_type_20", "title": "Health" , "ID": "HealthController"],
            // Graphic Image
            ["image": "item_type_21", "title": "Quatz2D" , "ID": "Quatz2DController"],
            ["image": "item_type_22", "title": "Gradation" , "ID": "GradationController"],
            // Request
            ["image": "item_type_23", "title": "Request Session" , "ID": "RequestSessionController"],
            ["image": "item_type_25", "title": "Background Task" , "ID": "BackgroundTaskController"],
            // Data Storage
            ["image": "item_type_24", "title": "Data Storage" , "ID": "DataStorageController"],

          ]
    }()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Set Row Number And Row Type
        table.setNumberOfRows(dataArray.count, withRowType: "ItemRowController")
        
        for (i, info) in dataArray.enumerated() {
            let cell = table.rowController(at: i) as! ItemRowController
            let index = String(i)
            let titleText = info["title"]! // index + ": " +
            cell.titleLabel.setText(titleText)
            cell.image.setImageNamed(info["image"])
        }
        
    }
    
    override func willActivate() {
        super.willActivate()
        shaker.delegate = self
        shaker.start()
    }
    override func didDeactivate() {
        super.didDeactivate()
        shaker.stop()
    }
    func textForIndex(i: Int) -> String {
        let index = String(i)
        let titleText = dataArray[i]["title"]! // index + ": " +
        return titleText
    }
    
    override func didAppear() {
        super.didAppear()
        let lastIndex = dataArray.count - 1
        currIndex =  0 // lastIndex
        table.scrollToRow(at: currIndex)
        
//        myTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.movingDown), userInfo: nil, repeats: true)
    }
    
    enum Direction {
        case Up
        case Down
    }
    
    @objc func movingUp(){
        let n = dataArray.count
        if currIndex >= 0 && currIndex < n {
            print("moving up to row: \(currIndex)")

            table.scrollToRow(at: currIndex)
            let curr_cell = table.rowController(at: currIndex) as! ItemRowController
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
            let boldString = NSMutableAttributedString(string: textForIndex(i: currIndex), attributes:attrs)
            curr_cell.titleLabel.setAttributedText(boldString)
        }
        
        let prevIndex = currIndex - 1
        if prevIndex >= 0 && prevIndex < n {
            let prevCell = table.rowController(at: prevIndex) as! ItemRowController
            let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]
            let regularString = NSMutableAttributedString(string: textForIndex(i: prevIndex), attributes:attrs)
            prevCell.titleLabel.setAttributedText(regularString)
        }
        
        currIndex += 1
        if currIndex >= n || currIndex <= 0 {
           // myTimer.invalidate()
        }
    }
    
    @objc func movingDown(){
        let n = dataArray.count
        print("moving down to row: \(currIndex)")
        table.scrollToRow(at: currIndex)
        let curr_cell = table.rowController(at: currIndex) as! ItemRowController
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let boldString = NSMutableAttributedString(string: textForIndex(i: currIndex), attributes:attrs)
        curr_cell.titleLabel.setAttributedText(boldString)
        
        let prevIndex = currIndex + 1
        if prevIndex >= 0 && prevIndex < n {
            let prevCell = table.rowController(at: prevIndex) as! ItemRowController
            let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]
            let regularString = NSMutableAttributedString(string: textForIndex(i: prevIndex), attributes:attrs)
            prevCell.titleLabel.setAttributedText(regularString)
        }
        
        currIndex -= 1
        if currIndex >= n || currIndex <= 0 {
           // myTimer.invalidate()
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        //pushController(withName: dataArray[rowIndex]["ID"]!, context: dataArray[rowIndex])
    }

}

extension ItemListController: WatchShakerDelegate {
    func watchShaker(_ watchShaker: WatchShaker, didShakeWith sensibility: ShakeSensibility) {
        print("shaked with sensibility: \(sensibility)")
        self.movingUp()
    }
    
    func watchShakerDidShake(_ watchShaker: WatchShaker) {
        print("YOU HAVE SHAKEN YOUR ⌚️⌚️⌚️")
    }

    func watchShaker(_ watchShaker: WatchShaker, didFailWith error: Error) {
        print(error.localizedDescription)
    }
}
