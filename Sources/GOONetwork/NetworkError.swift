import Foundation

enum NetworkError: String, Error, Identifiable, CaseIterable {
    case urlError
    case responseError
    case dataError
    case decodeError
    case unknownError

    var id: NetworkError { self }

    var localizedDescription: String {
        switch self {
            case .urlError:
                return "There was an error with the URL."
            case .responseError:
                return "There was an error with the server's response."
            case .dataError:
                return "There was an error with the data returned by the server."
            case .decodeError:
                return "There was an error decoding the data returned by the server."
            case .unknownError:
                return "An unknown error occurred."
        }
    }
}
