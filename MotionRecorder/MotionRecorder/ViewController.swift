//
//  ViewController.swift
//  MotionRecorder
//
//  Created by Alejandrina Gonzalez Reyes on 2/6/21.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Direction.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        let row = indexPath.row
        let direction = Direction.all[row].rawValue
        if self.directionMovesReceived[direction] != nil {
            cell.countLabel.text = String(self.directionMovesReceived[direction]!)
        } else {
            cell.countLabel.text = "0"
        }
        cell.titleLabel.text = direction
        return cell
    }

    @IBOutlet weak var table: UITableView!
    
    var lastDirection = "" // last direction used
    var model = MotionDataModel()
    var directionMovesReceived = Dictionary<String, Int>() // keep track of movements received

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("iPhone: \(activationState)")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("iPhone: \(applicationContext)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage")
        
        if let data = message["message"] as? String {
            print("Motion Direction: \(data)")
            self.lastDirection = data
            if self.directionMovesReceived[data] != nil {
                self.directionMovesReceived[data]! += 1
            } else {
                self.directionMovesReceived[data] = 1
            }
            print(self.directionMovesReceived)
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        
        if let jsonData = message["jsonData"] as? Data {
            print("Json Motion Data: \(jsonData)")
            
            let motion = try! JSONDecoder().decode([Motion].self, from: jsonData)
            
            if self.lastDirection != "" {
                parseMotionDataToCVS(direction: self.lastDirection, motionArray: motion)
                printMotionCVSFile()
                printMotionCVSFilePath()
            }
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("iPhone: \(session)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("iPhone:  \(session)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        createNewMotionCVSFile(override: true)
    }

}
