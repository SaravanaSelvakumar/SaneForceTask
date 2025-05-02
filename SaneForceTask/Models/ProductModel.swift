

import Foundation
import Combine

class Product: Identifiable, ObservableObject, Codable {
    let id = UUID().uuidString

    @Published var product_code: String = ""
    @Published var product_name: String = ""
    @Published var product_unit: String = ""
    @Published var convQty: String = ""
    var productQty : Int {
        return Int(convQty) ?? 0
    }

    enum CodingKeys: String, CodingKey {
        case product_code
        case product_name
        case product_unit
        case convQty
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        product_code = try container.decode(String.self, forKey: .product_code)
        product_name = try container.decode(String.self, forKey: .product_name)
        product_unit = try container.decodeIfPresent(String.self, forKey: .product_unit) ?? ""
        convQty = try container.decode(String.self, forKey: .convQty)
    }
    
    init() {
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(product_code, forKey: .product_code)
        try container.encode(product_name, forKey: .product_name)
        try container.encodeIfPresent(product_unit, forKey: .product_unit)
        try container.encode(convQty, forKey: .convQty)
    }
}

