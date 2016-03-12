//
//  FXLocalized.swift
//  FXHydra
//
//  Created by kioshimafx on 3/12/16.
//  Copyright © 2016 FXSolutions. All rights reserved.
//

import UIKit

//func FXLocalized(text: String!) -> String! {
//    if text == nil {
//        return nil
//    }
//    
//    let appRes = NSLocalizedString(text, comment: "")
//    
//    if (appRes != text) {
//        return appRes
//    }
//    
//    for t in tables {
//        let res = NSLocalizedString(text, tableName: t.table, bundle: t.bundle, value: text, comment: "")
//        if (res != text) {
//            return res
//        }
//    }
//    
//    return NSLocalizedString(text, tableName: nil, bundle: NSBundle.framework, value: text, comment: "")
//}