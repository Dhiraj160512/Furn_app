import Flutter
import UIKit
// Add the GoogleMaps import.
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDbYX0gLYCuKmIEQbC65wbXIktcdnOBeuc")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
