import SwiftUI

#warning("actually do work to implement this better")
extension Binding {
    @inline(__always)
    func map<T>(getter: @Sendable @escaping (Value) -> T, setter: @Sendable @escaping (T) -> Value) -> Binding<T> {
        Binding<T>(
            get: { getter(wrappedValue) },
            set: {
                wrappedValue = setter($0)
            }
        )
    }
}
