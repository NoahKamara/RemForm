
//public struct FormProperty<Value> {}
//
internal protocol ResolvableFormSummary: Codable {
    typealias Summary = FormSchema.Summary
    func resolve(with bindings: FormValues) -> Summary
}

// MARK: Configuration
public extension FormSchema {
    indirect enum Configuration: ResolvableFormSummary {
        case summary(Summary)
        case when(WhenCondition)
        case `switch`(SwitchCondition)

        func resolve(with bindings: FormValues) -> ResolvableFormSummary.Summary {
            switch self {
            case .summary(let summary): summary
            case .when(let whenCondition): whenCondition.resolve(with: bindings)
            case .switch(let switchCondition): switchCondition.resolve(with: bindings)
            }
        }
    }
}



// MARK: Condition
internal protocol EvaluatableFormCondition: Codable {
    func evaluate(with bindings: FormValues) -> Bool
}


public extension FormSchema {
    struct Condition: EvaluatableFormCondition {
        func evaluate(with bindings: FormValues) -> Bool {
            #warning("conditions override")
            return true
        }
    }
}



// MARK: When
public extension FormSchema {
    struct WhenCondition: ResolvableFormSummary {
        public let condition: Condition
        public let when: Configuration
        public let otherwise: Configuration

        public init(condition: Condition, when: Configuration, otherwise: Configuration) {
            self.condition = condition
            self.when = when
            self.otherwise = otherwise
        }

        func resolve(with bindings: FormValues) -> Summary {
            if condition.evaluate(with: bindings) {
                when.resolve(with: bindings)
            } else {
                otherwise.resolve(with: bindings)
            }
        }
    }
}



// MARK: Switch
public extension FormSchema {
    struct SwitchCase: EvaluatableFormCondition, ResolvableFormSummary {
        public let condition: Condition
        public let result: Configuration

        func evaluate(with bindings: FormValues) -> Bool {
            condition.evaluate(with: bindings)
        }

        func resolve(with bindings: FormValues) -> Summary {
            result.resolve(with: bindings)
        }
    }

    struct SwitchCondition: ResolvableFormSummary {
        public let cases: [SwitchCase]
        public let defaultCase: Configuration

        func resolve(with bindings: FormValues) -> Summary {
            for switchCase in cases {
                if switchCase.evaluate(with: bindings) {
                    return switchCase.resolve(with: bindings)
                }
            }

            return defaultCase.resolve(with: bindings)
        }
    }
}
