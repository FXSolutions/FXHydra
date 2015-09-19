//
//  dispatch.swift
//  StreamUsingSwift
//
//  Created by Static Ga on 14-9-19.
//  Copyright (c) 2014年 Static Ga. All rights reserved.
//

import Foundation

class dispatch {
    class async {
        class func global(block: dispatch_block_t) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
        }
        
        class func main(block: dispatch_block_t) {
            dispatch_async(dispatch_get_main_queue(), block);
        }
    }
    
    class sync {
        class func global(block: dispatch_block_t) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
        }
        
        class func main(block: dispatch_block_t) {
            if NSThread.isMainThread() {
                block()
            }
            else {
                dispatch_sync(dispatch_get_main_queue(), block)
            }
            
        }
    }
}