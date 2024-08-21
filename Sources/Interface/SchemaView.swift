
import SwiftUI
import Natural

public struct SchemaView: View {
    let schema: FormSchema

    @Bindable
    var bindings: FormBindings

    public init(schema: FormSchema, bindings: FormBindings? = nil) {
        self.schema = schema
        self.bindings = bindings ?? .init()
    }

    typealias Element = (offset: Int, element: FormSchema.Summary.Word)

    var params: [Element] {
        Array(schema.configuration.resolve(with: bindings.values).words.enumerated())
    }

    public var body: some View {
        Naturals {
            ForEach(params, id:\Element.offset) { element in
                switch element.element {
                case .word(let word): Text(word)
                case .parameter(let paramID):
                    if let parameter = schema.parameters.first(where: { $0.id == paramID }) {
                        ParameterView(
                            parameter: parameter,
                            value: $bindings[paramID]
                        )
                    } else {
                        Text("{\(paramID)}")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}


#Preview("Names Form") {
    @Previewable @Bindable var bindings = FormBindings(initialValues: .init(values: [
        "first_name": .primitive(.string("John"))
    ]))

    let schema = FormSchema(
        parameters: [
            .init(id: "last_name", type: .primitive(.string)),
            .init(id: "first_name", type: .primitive(.string))
        ],
        configuration: .summary("Enter your \("last_name") and \("first_name") to get a price.")
    )

    SchemaView(schema: schema, bindings: bindings)
}


#Preview("Debug") {
    @Previewable @Bindable var bindings = FormBindings(initialValues: .init(values: [
        "first_name": .primitive(.string("John"))
    ]))

    let schema = FormSchema(
        parameters: [
            .init(id: "first_name", type: .primitive(.string)),
            .init(id: "last_name", type: .primitive(.string)),
        ],
        configuration: .summary("Enter your \("first_name") and \("last_name") to get a price.")
    )

    VStack {
        SchemaView(schema: schema, bindings: bindings)
        FormValuesDebugView(schema: schema, values: bindings.values)
    }
}


extension FormSchema.Summary {
    enum Word {
        case word(String)
        case parameter(String)
    }

    var words: [Word] {
        format.split(separator: " ").map { substring in
            switch (substring.first, substring.last) {
            case ("{", "}"): .parameter(String(substring.dropFirst().dropLast()))
            default: .word(String(substring))
            }
        }
    }
}
