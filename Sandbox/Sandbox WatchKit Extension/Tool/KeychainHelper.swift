import Foundation

struct KeychainHelper {
    
    static func getKeychainQuery(service: String) -> NSMutableDictionary {
        return NSMutableDictionary(dictionary:
            [kSecClass: kSecClassGenericPassword,
             kSecAttrService: service,
             kSecAttrAccount: service,
             kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock])
    }
    
    static func saveKeychain(service: String, data: AnyObject) {
        let keychainQuery = self.getKeychainQuery(service: service)
        SecItemDelete(keychainQuery)
        keychainQuery.addEntries(from: [kSecValueData: NSKeyedArchiver.archivedData(withRootObject: data)])
        SecItemAdd(keychainQuery, nil)
    }
    
    static func readKeychain(service: String) -> AnyObject! {
        let keychainQuery = self.getKeychainQuery(service: service)
        keychainQuery.addEntries(from: [kSecReturnData: kCFBooleanTrue])
        keychainQuery.addEntries(from: [kSecMatchLimit: kSecMatchLimitOne])
        var keyData : AnyObject? = nil
        if SecItemCopyMatching(keychainQuery, &keyData) == noErr {
            let ret = NSKeyedUnarchiver.unarchiveObject(with: keyData as! Data)
            return ret as AnyObject
        } else {
            return nil
        }
    }
    
    static func deleteKeychain(service: String) {
        let keychainQuery = self.getKeychainQuery(service: service)
        SecItemDelete(keychainQuery)
    }
}
