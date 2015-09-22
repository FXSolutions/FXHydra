//
//  HRGroupModel.swift
//  Hydra
//
//  Created by Evgeny Evgrafov on 9/22/15.
//  Copyright © 2015 Evgeny Evgrafov. All rights reserved.
//

import Foundation


class HRGroupModel {
    
    var id          : Int!
    var is_closed   : Bool!
    var name        : String!
    var photo_100   : String!
    var screen_name : String!
    var type        : String!
    
    init(json : JSON) {
        
        self.id             = json["id"].intValue
        self.is_closed      = json["is_closed"].boolValue
        self.name           = json["name"].stringValue
        self.photo_100      = json["photo_100"].stringValue
        self.screen_name    = json["screen_name"].stringValue
        self.type           = json["type"].stringValue
        
    }
    
}