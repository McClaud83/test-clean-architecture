import Foundation
import Moya

struct AuthrisationTokePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        let key = Constants.UserDefaultsKeys.authToken.rawValue
        guard let token = UserDefaults.standard.string(forKey: key) else { return request }
        
        var request = request
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
