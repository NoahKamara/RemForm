import Foundation


extension ParseableFormatStyle where Self == FormValue.ParseableFormat {
    static func formValue(_ type: FormSchema.ValueType) -> Self {
        .init(type: type)
    }
}


// MARK: Parser
extension FormValue {
    struct ParseableFormat: ParseableFormatStyle {
        var formatStyle: Format = .init()
        let type: FormSchema.ValueType

        enum ParseError: Error {
            case invalidValue
        }

        func format(_ value: FormValue) -> String {
            formatStyle.format(value)
        }

        var parseStrategy: Strategy { Strategy(type: type) }

        struct Strategy: ParseStrategy {
            let type: FormSchema.ValueType

            func parse(_ value: String) throws -> FormValue {
                switch type {
                case .primitive(let primitive): .primitive(try .parse(value, as: primitive))
                    //                case .enum(let enum):           .enumCase(try .parse(value, as: enum))
                    //                case .entity(let entity):       .entity(try .parse(value, as: primitive))
                }
            }
        }
    }

}

// MARK: Primitive
extension FormValue.Primitive {
    @inline(__always)
    static func parse(_ value: String, as type: FormSchema.ValueType.Primitive) throws(FormValue.ParseableFormat.ParseError) -> Self {
        let parsed: Self? = switch type {
        case .int:      Int(value).map({ Self.int($0) })
        case .string:   .string(value)
        case .bool:     Bool(value).map({ Self.bool($0) })
        }

        guard let parsed else {
            throw .invalidValue
        }

        return parsed
    }
}
