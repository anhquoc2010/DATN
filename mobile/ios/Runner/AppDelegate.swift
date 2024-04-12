import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // GMSServices.provideAPIKey(Bundle.main.object(forInfoDictionaryKey:"googleMapspiKey") as? String ?? "")
    GMSServices.provideAPIKey("AIzaSyBzLfc7MLXuBxz_H9iy1Qv9NC4vREmscig")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
