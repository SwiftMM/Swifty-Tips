protocol Duplicatable {
    func duplicate() -> Self?
}

extension Duplicatable where Self: NSObject {
    func duplicate() -> Self? {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
    }
}

extension NSObject: Duplicatable {}
