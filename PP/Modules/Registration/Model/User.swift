import RealmSwift

@objcMembers
class User: Object, Codable {
    
    dynamic
    var name: String = ""
    
    dynamic
    var password: String = ""
    
}
