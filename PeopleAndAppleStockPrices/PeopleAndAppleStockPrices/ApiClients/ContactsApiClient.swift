//import Foundation

//public enum APPError: Error {
//
//        case badURL(String)
//        case networkError(Error)
//        case noResponse
//        case decodingError(Error)
//
//
//        public func errorMessage() -> String {
//            switch self {
//            case .badURL(let message):
//                return "badURL: \(message)"
//            case .networkError(let error):
//                return "networkError: \(error)"
//            case .noResponse:
//                return "no network response"
//            case .decodingError(let error):
//                return "decoding error: \(error)"
//            }
//        }
//    }
//
//
//
//final class ContactsAPIClient {
//    static func getContacts(complationHandler: @escaping((Result<Contancts, APPError> ) -> Void)) {
//        let urlString = "https://randomuser.me/api/?results=50"
//
//        guard let url = URL(string: urlString) else {
//            complationHandler(.failure(.badURL("bad url")))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) // completion handler here
//
//    }
//}

