import Flutter
import UIKit
import GoogleSignIn

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Configure Google Sign-In for Firebase
    let clientID = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String ?? "911840018429-t1g7n7u0udjtsl5fl98kstbupc6b5j96.apps.googleusercontent.com"
    let configuration = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = configuration
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Handle Google Sign-In callback
  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
