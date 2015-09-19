//
//  HRCurrentUserModel.swift
//  Hydra
//
//  Created by Evgeny Abramov on 8/2/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import Foundation

class HRUserModel: NSObject {
    
        
    var first_name : String!
    var last_name  : String!
    var user_id : Int!
    var photoURL   : String!
    
    init(json : JSON) {
        
        self.user_id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.photoURL = json["photo_200"].stringValue
        
    }
        
    
    
}
