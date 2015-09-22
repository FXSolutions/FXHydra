import Foundation

class HRAlbumModel {
    
    var album_id : Int!
    var owner_id  : Int!
    var title   : String!
    
    init(json : JSON) {
        
        self.album_id = json["id"].intValue
        self.owner_id = json["owner_id"].intValue
        self.title = json["title"].stringValue
        
    }
    

}
