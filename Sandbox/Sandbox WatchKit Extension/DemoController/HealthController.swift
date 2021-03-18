import UIKit
import WatchKit
import HealthKit

class HealthController: WKInterfaceController {
    
    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var startBtn: WKInterfaceButton!
    
    let healthStore = HKHealthStore()
    let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    let heartRateUnit = HKUnit(from: "count/min")
    var heartRateQuery: HKQuery?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if !HKHealthStore.isHealthDataAvailable() {
            label.setText("Not Available")
            return
        }
        
        let typesSet = Set([heartRateType])
        healthStore.requestAuthorization(toShare: nil, read: typesSet) { (success, error) -> Void in
            guard success else {
                self.label.setText("Not Allowed")
                return
            }
        }
    }
    
    @IBAction func fetchBtnTapped() {
        
        if heartRateQuery == nil {
            // start
            heartRateQuery = self.createStreamingQuery()
            healthStore.execute(self.heartRateQuery!)
            startBtn.setTitle("Stop")
        } else {
            // stop
            healthStore.stop(self.heartRateQuery!)
            heartRateQuery = nil
            startBtn.setTitle("Start")
        }
    }
    
    // MARK: - Private
    
    private func createStreamingQuery() -> HKQuery {
        let predicate = HKQuery.predicateForSamples(withStart: NSDate() as Date, end: nil, options: [])
        
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { (query, samples, deletedObjects, anchor, error) -> Void in
            self.addSamples(samples: samples)
        }
        query.updateHandler = { (query, samples, deletedObjects, anchor, error) -> Void in
            self.addSamples(samples: samples)
        }
        
        return query
    }
    
    private func addSamples(samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else { return }
        guard let quantity = samples.last?.quantity else { return }
        label.setText("\(quantity.doubleValue(for: heartRateUnit))")
    }
}
