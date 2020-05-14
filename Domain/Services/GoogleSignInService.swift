import Foundation
import RxSwift
import UIKit.UIViewController

public protocol GoogleSignInService {
    func signIn(on viewController: UIViewController) -> Single<GoogleUserInfo?>
    func refreshToken(on viewController: UIViewController) -> Single<String?> 
    func signOut() -> Single<Void?>
}
