import Foundation

struct Stock: Codable {
    private let date: String
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
    
//    func getStock() -> [String] {
//
//    }
    
    private enum CodingKeys: String, CodingKey {
        case date, opening = "open", closing = "close"
    }
    
    static func getStocks(from data: Data) -> [Stock] {
        do {
            let stocks = try
                JSONDecoder().decode([Stock].self, from: data)
            return stocks
        } catch {
            fatalError("Decoding Error")
        }
    }
}
