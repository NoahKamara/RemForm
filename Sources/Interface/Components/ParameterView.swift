import SwiftUI

struct ParameterView: View {
    let parameter: FormSchema.Parameter

    @Binding
    var value: FormValue?

    var body: some View {
        switch parameter.type {
        case .primitive(let primitive):
            switch primitive {
            case .string:
                TextField(parameter.id, value: $value, format: .formValue(.primitive(.string)))
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 120)

            case .int: Text(")")
            case .bool:
                Toggle(parameter.title, isOn: $value.map(
                    getter: { formValue in
                        if case .primitive(let primitive) = formValue, case .bool(let value) = primitive {
                            value
                        } else {
                            false
                        }
                    },
                    setter: { .primitive(.bool($0)) }
                ))
            }
        }
    }
}

