public enum MyError: Swift.Error {
    case status(code: Int, message: String)
}

extension MyError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .status(_, let message):
            return message
        }
    }
}

extension MyError: CustomNSError {

    public var errorCode: Int {
        switch self {
        case .status(let code, _):
            return code
        }
    }
    
    public var errorUserInfo: [String : Any] {
        var userInfo: [String: Any] = [:]
        userInfo[NSLocalizedDescriptionKey] = errorDescription
        return userInfo
    }
}

// Usage
let error: MyError = .status(code: 0, message: "Some error description.")
print(error.localizedDescription)
