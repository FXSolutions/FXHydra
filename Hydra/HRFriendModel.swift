//
//  HRFriendModel.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import UIKit

class HRFriendModel: NSObject {
    
    var user_id         : Int!
    var first_name      : String!
    var last_name       : String!
    var photo_100       : String!
    var online          : Bool!
    var can_see_audio   : Bool!
    
    init(json : JSON) {
        
        self.user_id            = json["id"].intValue
        self.first_name         = json["first_name"].stringValue
        self.last_name          = json["last_name"].stringValue
        self.photo_100          = json["photo_100"].stringValue
        self.online             = json["online"].boolValue
        self.can_see_audio      = json["can_see_audio"].boolValue
        
    }
    
}
