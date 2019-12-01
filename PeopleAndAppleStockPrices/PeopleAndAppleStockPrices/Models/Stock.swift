import Foundation

struct Stock: Codable {
    let date: String
    let opening: Double
    let closing: Double
    
    var day: String {
        return date.components(separatedBy: "-")[2]
    }
    var month: String {
        return date.components(separatedBy: "-")[1]
    }
    var year: String {
        return date.components(separatedBy: "-")[0]
    }
    
    // header for section in Table View
    var header: String {
        return "\(year) \(month)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case date
        case opening = "open"
        case closing = "close"
    }
}
