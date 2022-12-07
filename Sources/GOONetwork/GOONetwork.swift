import Foundation

@available(macOS 12.0, *)
@available(iOS 13.0, *)
public struct GOONetwork {

    static public func decodeJSON<T: Decodable>(fromUrl: String) async throws -> T? {
        var data: Data = Data()
        var response: URLResponse = URLResponse()

        guard let url = URL(string: fromUrl) else {
            throw NetworkError.urlError
        }

        do {
            let urlRequest = URLRequest(url: url)
            (data, response) = try await URLSession.shared.data(from: urlRequest.url!)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw NetworkError.responseError
            }
        } catch let err as NetworkError {
            throw err
        } catch {
            throw NetworkError.dataError
        }

        do {
            let decodedJSON = try JSONDecoder().decode(T.self, from: data)
            return decodedJSON
        } catch {
            throw NetworkError.decodeError
        }
    }

}

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
