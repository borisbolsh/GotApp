import Foundation

struct Character: Decodable {
    var id: UInt8
    var firstName: String
    var lastName: String
    var fullName:  String
    var title:  String
    var family: String
    var image: String
    var imageUrl:  String
}
