//
// Single menuitem for decoding from JSON
//

import Foundation

struct MenuItem: Decodable {
    let name:String
    let description:String
    let price:Float
    let image:String
    let category:String
}
