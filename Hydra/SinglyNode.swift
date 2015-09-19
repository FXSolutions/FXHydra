import Foundation

class Node<T> {
    var value: T?
    init(value: T?) {
        self.value = value
    }
}
class HeadNode<T> {
    var next: T?
}
class SinglyNode<T>: Node<T> {
    var key: String
    var next: SinglyNode<T>?
    init(key: String, value: T, nextNode: SinglyNode<T>?) {
        self.next = nextNode
        self.key = key
        super.init(value: value)
    }
}


