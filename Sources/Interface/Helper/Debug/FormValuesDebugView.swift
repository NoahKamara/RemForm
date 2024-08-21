import SwiftUI

struct FormValuesDebugView: View {
    let schema: FormSchema
    let values: FormValues

    var body: some View {
        Form {
            ForEach(schema.parameters, id:\.id) { param in
                LabeledContent {
                    VStack(alignment: .trailing) {
                        if let value = values[param.id] {
                            Text(value, format: .formValue)
                        } else {
                            Text("No Value")
                                .italic()
                                .foregroundStyle(.red.tertiary)
                        }

                        Text(param.type.description)
                            .font(.caption)
                            .italic()
                            .foregroundStyle(.secondary)
                    }
                } label: {
                    VStack(alignment: .leading) {
                        Text(param.title)
                        Text(param.id)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    FormValuesDebugView(
        schema: .init(
            parameters: [],
            configuration: .summary("")
        ),
        values: FormValues(values: [
            "first_name": .primitive(.string("John"))
        ])
    )
}
