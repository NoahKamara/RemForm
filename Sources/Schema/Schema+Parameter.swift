

// MARK: Parameter
public extension FormSchema {
    struct Parameter: Codable {
        public typealias ID = String

        public let id: ID
        public var title: String { id }
        public let type: ValueType
    }
}


// MARK: ValueType
public extension FormSchema {
    enum ValueType: Codable, Equatable, Hashable, CustomStringConvertible {
        case primitive(Primitive)

        public var description: String {
            switch self {
            case .primitive(let primitive): primitive.description
            }
        }

        public enum Primitive: Codable, Equatable, CustomStringConvertible {
            case string
            case int
            case bool

            public var description: String {
                switch self {
                case .string: "string"
                case .int: "int"
                case .bool: "bool"
                }
            }
        }
    }
}
