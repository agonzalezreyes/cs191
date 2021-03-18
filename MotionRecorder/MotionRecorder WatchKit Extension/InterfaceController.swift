//
//  InterfaceController.swift
//  MotionRecorder WatchKit Extension
//
//  Created by Alejandrina Gonzalez Reyes on 2/6/21.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    var recorder = TimedMotionRecorder(startAfter: .seconds(0), recordFor: .seconds(3))
    private var sender = Sender()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.setTitle("Motion Rec")

        table.setNumberOfRows(Direction.all.count, withRowType: "ItemRowController")
        for (i, item) in Direction.all.enumerated() {
            let cell = table.rowController(at: i) as! ItemRowController
            cell.titleLabel.setText(item.rawValue)
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let direction : String = Direction.all[rowIndex].rawValue
        collectMotion(direction)
        
        let cell = table.rowController(at: rowIndex) as! ItemRowController
        cell.titleLabel.setTextColor(.red)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            cell.titleLabel.setTextColor(.white)
        }
    }
    
    func collectMotion(_ direction: String){
        print("data to send: \(direction)")
        sender.send(direction)
        recorder.start()
    }
    
    override func willActivate() {
        super.willActivate()
//        if WCSession.isSupported() {
//            let session = WCSession.default
//            session.delegate = self
//            session.activate()
//        }
    }

//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        print("WatchOS: Activation state: \(activationState)")
//    }
//
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        print("WatchOS: \(applicationContext)")
//    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
