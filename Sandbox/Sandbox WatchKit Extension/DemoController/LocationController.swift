import UIKit
import WatchKit
import CoreLocation

class LocationController: WKInterfaceController {

    @IBOutlet var latitudeLabel: WKInterfaceLabel!
    @IBOutlet var longitudeLabel: WKInterfaceLabel!
    @IBOutlet var altitudeLabel: WKInterfaceLabel!
    @IBOutlet var floorLabel: WKInterfaceLabel!
    @IBOutlet var speedLabel: WKInterfaceLabel!
    @IBOutlet var courseLabel: WKInterfaceLabel!
    @IBOutlet var HorAccLabel: WKInterfaceLabel!
    @IBOutlet var VerAccLabel: WKInterfaceLabel!
    @IBOutlet var timeLabel: WKInterfaceLabel!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.distanceFilter = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let state = CLLocationManager.authorizationStatus()
        if state != .authorizedAlways && state != .authorizedWhenInUse {
            print("Please Authorize In Your iPhone App")
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.startUpdatingLocation()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        locationManager.stopUpdatingLocation()
    }
}


extension LocationController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        
        if let coordinate = currentLocation?.coordinate {
            latitudeLabel.setText(String(format: "%.2f", coordinate.latitude))
            longitudeLabel.setText(String(format: "%.2f", coordinate.longitude))
        }
        if let altitude = currentLocation?.altitude {
            altitudeLabel.setText(String(format: "%.2f", altitude))
        }
        if let floor = currentLocation?.floor {
            floorLabel.setText(String(floor.level))
        }
        if let speed = currentLocation?.speed {
            speedLabel.setText(String(format: "%.2f", speed))
        }
        if let course = currentLocation?.course {
            courseLabel.setText(String(format: "%.2f", course))
        }
        if let timestamp = currentLocation?.timestamp {
            timeLabel.setText(timestamp.description)
        }
        if let horizontalAccuracy = currentLocation?.horizontalAccuracy {
            HorAccLabel.setText(String(format: "%.2f", horizontalAccuracy))
        }
        if let verticalAccuracy = currentLocation?.verticalAccuracy {
            VerAccLabel.setText(String(format: "%.2f", verticalAccuracy))
        }
    }
}
