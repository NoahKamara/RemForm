import Foundation

@Observable
public class FormBindings {
    public typealias Key = FormSchema.Parameter.ID

    public private(set) var values: FormValues

    public init(initialValues values: FormValues? = nil) {
        self.values = values ?? FormValues()
    }

    public subscript(_ key: Key, defaultValue: FormValue) -> FormValue {
        self[key] ?? defaultValue
    }

    subscript(_ key: Key) -> FormValue? {
        get {
            access(keyPath: \.values)
            return self.values[key]
        }
        set {
            newValue.map({ set($0, forKey: key) }) ?? self.reset(key)
        }
    }

    public func set(_ newValue: FormValue, forKey key: Key) {
        withMutation(keyPath: \.values) {
            values.set(newValue, forKey: key)
        }
    }

    public func reset(_ key: Key) {
        withMutation(keyPath: \.values) {
            values.resetValue(forKey: key)
        }
    }
}
