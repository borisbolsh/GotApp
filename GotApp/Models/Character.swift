import Foundation

struct Character: Decodable {
  let id: UInt8
  let firstName: String?
  let lastName: String
  let fullName: String
  let title: String
  let family: String
  var image: String
  let imageUrl: String
}
