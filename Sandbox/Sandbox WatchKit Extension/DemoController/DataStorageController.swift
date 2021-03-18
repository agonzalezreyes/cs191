import WatchKit
import UIKit

class DataStorageController: WKInterfaceController {
        
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Keychain Storage
        let saveKey = "Sandbox"
        let saveString = "Save Sandbox"
        saveToKeychain(key: saveKey, text: saveString)
        
        // Keychain Reading
        let text = readFromKeychain(key: saveKey)
        print(text ?? "Keychain: Found Nothing by \(saveKey)")
        
        // Accessing Settings at Runtime
        if let defaults = UserDefaults(suiteName: groupKeyTemp) {
            let numberString = defaults.object(forKey: "number")
            print(numberString ?? "UserDefaults: 'number' is Null")
        }
        
        // Use App Group URL
        let groupContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupKeyRecord)
        let textURL = groupContainer!.appendingPathComponent("record.text")
        print(textURL)
        
        do {
            let text = try String(contentsOf: textURL, encoding: String.Encoding.utf8)
            print(text)
        } catch {
            print("error")
        }
        
        
        // WatchKit Extension SandBox Path
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachePath = paths[0]
        print(cachePath)
                
    }
    
    func saveToKeychain(key: String, text: String) {
        let data = text.data(using: String.Encoding.unicode) as AnyObject
        KeychainHelper.saveKeychain(service: key, data: data)
    }
    
    func readFromKeychain(key: String) -> String? {
        var text: String?
        if let data = KeychainHelper.readKeychain(service: key) as? Data {
            text = String(data: data, encoding: String.Encoding.unicode)
        }
        return text
    }
    
}




