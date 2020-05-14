import Foundation
import Moya

enum ContactsAPI {
    case contacts
}

extension ContactsAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.ContactsListUrl)!
    }
    
    var path: String {
        switch self {
            case .contacts: return "full"
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any] {
        switch self {
            case .contacts:
                return ["alt":"json"]
        }
    }

}
