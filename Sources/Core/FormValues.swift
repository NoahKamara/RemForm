

public struct FormValues: Codable {
    public typealias Key = FormSchema.Parameter.ID

    private var values: [Key: FormValue]

    init(values: [Key: FormValue]) {
        self.values = values
    }

    public init() {
        self.init(values: [:])
    }

    public subscript(_ key: Key) -> FormValue? {
        values[key]
    }

    mutating public func set(_ newValue: FormValue, forKey key: Key) {
        values[key] = newValue
    }

    mutating public func resetValue(forKey key: Key) {
        _ = values.removeValue(forKey: key)
    }
}

// MARK: Values
public enum FormValue: Equatable, Codable {
    case primitive(Primitive)
}


// MARK: Primitive
public extension FormValue {
    enum Primitive: Equatable, Codable {
        case int(Int)
        case string(String)
        case bool(Bool)
    }
}
