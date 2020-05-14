import Domain
import GoogleSignIn
import UIKit.UIViewController
import RxSwift

class GoogleSignInServiceImpl: NSObject, Domain.GoogleSignInService {

    fileprivate let signInResultSubject = PublishSubject<GoogleUserInfo?>()
    fileprivate let refreshResultSubject = BehaviorSubject<GoogleUserInfo?>(value: nil)
    fileprivate let signOutResultSubject = PublishSubject<Void?>()
    
    override init() {
        super.init()
        
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.clientID = Environment.googleApiKey
        googleInstance.delegate = self
        googleInstance.scopes.append(Constants.GoogleContactsScope)
    }
    
    func signIn(on viewController: UIViewController) -> Single<GoogleUserInfo?> {
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.presentingViewController = viewController
        googleInstance.signIn()
        return self.signInResultSubject
            .take(1)
            .asSingle()
            .debug("signIn")
    }
    
    func refreshToken(on viewController: UIViewController) -> Single<String?> {
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.presentingViewController = viewController
        googleInstance.restorePreviousSignIn()
        return self.refreshResultSubject
            .take(1)
            .map { $0?.authToken }
            .asSingle()
            .debug("refresh")
    }

    func signOut() -> Single<Void?> {
        let googleInstance = GIDSignIn.sharedInstance()!
        googleInstance.disconnect()
        googleInstance.signOut()
        return self.signOutResultSubject
            .take(1)
            .asSingle()
    }
        
}

extension GoogleSignInServiceImpl: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("signIn error:", error)
            signInResultSubject.onError(error)
            return
        }
        let result = GoogleUserInfo(
            id: user.userID!,
            authToken: user.authentication.accessToken!,
            name: user.profile!.name
        )
        print("signIn result:", result)
        signInResultSubject.onNext(result)
        refreshResultSubject.onNext(result)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("signOUT error:", error)
            signOutResultSubject.onError(error)
            return
        }
        signOutResultSubject.onNext(())
    }
}
