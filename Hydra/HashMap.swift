

import Foundation

struct HashMap<T> {
    var table = Array<SinglyLinkedList<AnyObject>?>()
    init() {
        for _ in 0...99 {
            table.append(SinglyLinkedList<AnyObject>())
        }
    }
    
    private func hashString(s: String) -> Int {
        var returnNum = 0
        let scalars = s.unicodeScalars
        for scalar in scalars {
            returnNum += Int(scalar.value)
        }
        return returnNum % 10 // we will only have 100 buckets
    }
    mutating func setKey(key: String, withValue val: AnyObject) {
        let hashedString = hashString(key)
        if let collisionList = table[hashedString] {
            collisionList.upsertNodeWithKey(key, AndValue: val)
        } else {
            table[hashedString] = SinglyLinkedList<AnyObject>()
            table[hashedString]!.upsertNodeWithKey(key, AndValue: val)
        }
    }
    func getValueAtKey(key: String) -> AnyObject? {
        let hashedString = hashString(key)
        if let collisionList = table[hashedString] {
            return collisionList.findNodeWithKey(key)?.value
        } else {
            return nil
        }
    }
}
