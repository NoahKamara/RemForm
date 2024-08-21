

public extension FormSchema {
    struct Summary: Codable, ExpressibleByStringInterpolation {
        public let format: String
        public let parameters: [String]
        public let otherParameters: [String]

        public init(format: String, parameters: [String], otherParameters: [String]) {
            self.format = format
            self.parameters = parameters
            self.otherParameters = otherParameters
        }

        public init(_ interpolation: SummaryString, otherParameters: [String] = []) {
            self.init(
                format: interpolation.format,
                parameters: interpolation.parameters,
                otherParameters: []
            )
        }

        public init(stringLiteral value: String) {
            self.init(format: value, parameters: [], otherParameters: [])
        }

        public init(stringInterpolation: SummaryString.StringInterpolation) {
            self.init(
                format: stringInterpolation.format,
                parameters: stringInterpolation.parameters,
                otherParameters: []
            )
        }
    }

}


// MARK: SummaryString
public extension FormSchema {
    struct SummaryString  {
        public let format: String
        public let parameters: [String]

        public init(format: String, parameters: [String]) {
            self.format = format
            self.parameters = parameters
        }

        public init(stringLiteral value: String) {
            self.init(format: value, parameters: [])
        }

        public init(stringInterpolation: StringInterpolation) {
            self.init(
                format: stringInterpolation.format,
                parameters: stringInterpolation.parameters
            )
        }

        public struct StringInterpolation: StringInterpolationProtocol {
            public private(set) var parameters: [String] = []
            public private(set) var format: String = ""

            public init(literalCapacity: Int, interpolationCount: Int) {}

            public mutating func appendLiteral(_ literal: StringLiteralType) {
                format.append(literal)
            }

            public mutating func appendInterpolation(_ parameterID: String) {
                self.parameters.append(parameterID)
                self.format.append("{\(parameterID)}")
            }

            public mutating func appendInterpolation(_ parameter: Parameter) {
                self.appendInterpolation(parameter.id)
            }
        }
    }
}
