import Foundation

struct SinglyLinkedList<T> {
    var head = HeadNode<SinglyNode<T>>()
    func findNodeWithKey(key: String) -> SinglyNode<T>? {
        if var currentNode = head.next {
            while currentNode.key != key {
                if let nextNode = currentNode.next {
                    currentNode = nextNode
                } else {
                    return nil
                }
            }
            return currentNode
        } else {
            return nil
        }
    }
    func upsertNodeWithKey(key: String, AndValue val: T) -> SinglyNode<T> {
        if var currentNode = head.next {
            while let nextNode = currentNode.next {
                if currentNode.key == key {
                    break
                } else {
                    currentNode = nextNode
                }
            }
            if currentNode.key == key {
                currentNode.value = val
                return currentNode
            } else {
                currentNode.next = SinglyNode<T>(key: key, value: val, nextNode: nil)
                return currentNode.next!
            }
        } else {
            head.next = SinglyNode<T>(key: key, value: val, nextNode: nil)
            return head.next!
        }
    }
    func displayNodes() {
        print("Printing Nodes", terminator: "")
        if var currentNode = head.next {
            print("First Node's Value is \(currentNode.value!)", terminator: "")
            while let nextNode = currentNode.next {
                currentNode = nextNode
                print("Next Node's Value is \(currentNode.value!)", terminator: "")
            }
        } else {
            print("List is empty", terminator: "")
        }
    }
}