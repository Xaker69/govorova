import RealmSwift

@objcMembers
class LectureModel: Object, Codable {
    dynamic
    var name: String = "noName"
    
    dynamic
    var lessons = List<LessonModel>()
    
    dynamic
    var isShort: Bool! = true
}

@objcMembers
class AudienceModel: Object, Codable {
    dynamic
    var roomNumber: Int = -1
    
    dynamic
    var type: String = "noType"
    
    dynamic
    var roominess: Int = -1
}

@objcMembers
class LessonModel: Object, Codable {
    dynamic
    var type: String = "noType"
    
    dynamic
    var timeStart: Date = .init(timeIntervalSince1970: 0)
    
    dynamic
    var timeEnd: Date = .init(timeIntervalSince1970: 0)
    
    dynamic
    var dayOfWeek: String = "noDay"
    
    dynamic
    var groupNumber: Int = -1
    
    dynamic
    var code: Int = -1
    
    dynamic
    var name: String = "noName"
    
    dynamic
    var audience: AudienceModel! = AudienceModel()
}
