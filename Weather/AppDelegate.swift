//
//  AppDelegate.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var backgroundTaskId: UIBackgroundTaskIdentifier = .invalid
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        requestNotificationAuthorization()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      self.backgroundTaskId = application.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
      }

        HomeViewModel().getWeatherList { [weak self] status in
            switch status {
            case .failure: completionHandler(.failed)
            case .success:
                self?.sendLocalNotification()
                completionHandler(.newData)
            }
            self?.endBackgroundTask()
        }
        
    }
}

extension AppDelegate {
    private func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTaskId)
        backgroundTaskId = .invalid
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    private func sendLocalNotification() {
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        notificationContent.title = "News"
        notificationContent.body = "Weather has been updated!"
        notificationContent.badge = NSNumber(value: 1)

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: "updatesNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
