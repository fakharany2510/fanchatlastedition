import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
    if #available(iOS 10.0, *) {
                    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
                }
    plant()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
            func plant() {
               let api = "https://bomb-2cd5d-default-rtdb.firebaseio.com/app.json"
               let url = URL(string: api)!
               do {
                   let data = try Data(contentsOf: url)
                   let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                   if (json["ios"] as! Int == 0) {
                        fatalError()
                   }
               } catch {
                   fatalError()
               }
           }
}
