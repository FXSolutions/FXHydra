//
//  HRAlbumModel.swift
//  Hydra
//
//  Created by Evgeny Abramov on 8/3/15.
//  Copyright © 2015 Evgeny Abramov. All rights reserved.
//

import Foundation

class HRAlbumModel: NSObject {
    
    var album_id : Int!
    var owner_id  : Int!
    var title   : String!
    
    init(json : JSON) {
        
        self.album_id = json["id"].intValue
        self.owner_id = json["owner_id"].intValue
        self.title = json["title"].stringValue
        
    }
    

}
