import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
  
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        beginUserStory()
        return true
    }
  
    private func beginUserStory() {
        let window = UIWindow()
        self.window = window
        AppRouter().showLoading()
    }
}

