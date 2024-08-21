import Foundation

// MARK: Format
extension FormValue {
    struct Format: FormatStyle {
        func format(_ value: FormValue) -> String {
            switch value {
            case .primitive(let primitive): primitive.formatted()
                //            case .enumCase(let enumCase): enumCase.formatted()
                //            case .entity(let entity): entity.formatted()
            }
        }
    }
}

extension FormatStyle where Self == FormValue.Format {
    static var formValue: Self { Self() }
}


// MARK: Primitive
extension FormValue.Primitive {
    @inline(__always)
    func formatted() -> String {
        switch self {
        case .int(let int): int.formatted()
        case .string(let string): string
        case .bool(let bool): bool ? "Yes" : "No"
        }
    }
}
