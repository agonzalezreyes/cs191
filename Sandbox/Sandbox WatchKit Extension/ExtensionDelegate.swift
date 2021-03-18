import WatchKit
import UserNotifications


class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        configureNotification()
        backgroundRefresher()
    }
    
    func backgroundRefresher() {
        WKExtension.shared().scheduleSnapshotRefresh(withPreferredDate: Date(), userInfo: nil) { (error) in
            print("scheduleSnapshotRefresh")
        }

        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Date(), userInfo: nil) { (error) in
            print("scheduleBackgroundRefresh")
        }
    }
    
    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(true)
                print("WKApplicationRefreshBackgroundTask")
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
                print("WKSnapshotRefreshBackgroundTask")
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(true)
                print("WKWatchConnectivityRefreshBackgroundTask")
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(true)
                print("WKURLSessionRefreshBackgroundTask")
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(true)
                print("Default")
            }
        }
    }
    
}

extension ExtensionDelegate: UNUserNotificationCenterDelegate {
    
    func configureNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("notification success")
            } else {
                print("notification failure")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Update the app interface directly.
        print("willPresentNotification")

        // Play a sound.
        completionHandler(UNNotificationPresentationOptions.sound)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        handleNotificationResponse(response: response)
    }
    
    func handleNotificationResponse(response: UNNotificationResponse) {
        // CustomCategory
        if response.notification.request.content.categoryIdentifier == "customCategoryIdentifier" {
            
            if response.actionIdentifier == "KonwID" {
                print("Konw Action")
            } else if response.actionIdentifier == "NotCareID" {
                print("Don't Care Action")
            } else if response.actionIdentifier == "NotPushID" {
                print("Don't Push Action")
            } else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                print("Default Action: Did Not Specify Custom ActionID")
            } else if response.actionIdentifier == UNNotificationDismissActionIdentifier {
                print("Dismiss Action: Specify A Dismiss Action")
            } else {
                
            }
        } else if response.notification.request.content.categoryIdentifier.isEmpty {
            // Default Category
        }
    }
    
}
