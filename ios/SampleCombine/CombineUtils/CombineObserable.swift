//
//  CombineObserable.swift
//  SampleCombine
//
//  Created by Gijs van Veen on 25/09/2020.
//

import SwiftUI
import Combine
import SampleCombineShared

class CombineObservable<T : Equatable, O : AnyObject> : ObservableObject {
  @Published private(set) var value: T
  private let disposeBag = DisposeBag()
    init(architectureObservable: ArchitectureObservable<O>, defaultValue: T, mapper: @escaping (O) -> T) {
        self.value = defaultValue
        architectureObservable.observe { [unowned self] (newValue) in
            var typedValue: T = defaultValue
            if let newValue = newValue {
                typedValue = mapper(newValue)
            }
            guard (typedValue != self.value) else {
                return
            }
            self.value = typedValue
        }.addTo(disposeBag: disposeBag)
  }
  deinit {
    disposeBag.dispose()
  }
}

class SimpleCombineObservable<T : AnyObject & Equatable> : CombineObservable<T, T> {
    init(architectureObservable: ArchitectureObservable<T>, defaultValue: T) {
        super.init(architectureObservable: architectureObservable, defaultValue: defaultValue, mapper: {$0})
    }
}

class StringCombineObservable : CombineObservable<String, NSString> {
    init(architectureObservable: ArchitectureObservable<NSString>, defaultValue: String = "") {
        super.init(architectureObservable: architectureObservable, defaultValue: defaultValue, mapper: { String($0) })
    }
}

class IntCombineObservable : CombineObservable<Int, NSNumber> {
    init(architectureObservable: ArchitectureObservable<NSNumber>, defaultValue: Int = 0) {
        super.init(architectureObservable: architectureObservable, defaultValue: defaultValue, mapper: { $0.intValue })
    }
}

class FloatCombineObservable : CombineObservable<Float, NSNumber> {
    init(architectureObservable: ArchitectureObservable<NSNumber>, defaultValue: Float = 0) {
        super.init(architectureObservable: architectureObservable, defaultValue: defaultValue, mapper: { $0.floatValue })
    }
}

class DoubleCombineObservable : CombineObservable<Double, NSNumber> {
    init(architectureObservable: ArchitectureObservable<NSNumber>, defaultValue: Double = 0) {
        super.init(architectureObservable: architectureObservable, defaultValue: defaultValue, mapper: { $0.doubleValue })
    }
}

class BoolCombineObservable : CombineObservable<Bool, NSNumber> {
    init(architectureObservable: ArchitectureObservable<NSNumber>, defaultValue: Bool = false) {
        super.init(architectureObservable: architectureObservable, defaultValue: defaultValue, mapper: { $0.boolValue })
    }
}

class CombineSubject<T : Equatable, O : AnyObject> : ObservableObject {
    @Published var value: T
    private let disposeBag = DisposeBag()
    var subscription: AnyCancellable!

    init(architectureSubject: ArchitectureSubject<O>, defaultValue: T, toMapper: @escaping (O) -> T, fromMapper: @escaping (T) -> O) {
        self.value = defaultValue
        architectureSubject.observe { [unowned self] (newValue) in
            var typedValue: T = defaultValue
            if let newValue = newValue {
                typedValue = toMapper(newValue)
            }
            guard (typedValue != self.value) else {
                return
            }
            self.value = typedValue
        }.addTo(disposeBag: disposeBag)
        subscription = _value.projectedValue
            .sink { value in
                var typedCurrentValue: T = defaultValue
                if let currentValue = architectureSubject.currentOrNull {
                    typedCurrentValue = toMapper(currentValue)
                }
                guard value != typedCurrentValue else {
                    return
                }
                architectureSubject.post(newValue: fromMapper(value))
            }
    }
    
  deinit {
    disposeBag.dispose()
  }
}

class SimpleCombineSubject<T : AnyObject & Equatable> : CombineSubject<T, T> {
    init(architectureSubject: ArchitectureSubject<T>, defaultValue: T) {
        super.init(architectureSubject: architectureSubject, defaultValue: defaultValue, toMapper: {$0}, fromMapper: {$0})
    }
}

class StringCombineSubject : CombineSubject<String, NSString> {
    init(architectureSubject: ArchitectureSubject<NSString>, defaultValue: String = "") {
        super.init(architectureSubject: architectureSubject, defaultValue: defaultValue, toMapper: { String($0) }, fromMapper: { $0 as NSString })
    }
}

class IntCombineSubject : CombineSubject<Int, NSNumber> {
    init(architectureSubject: ArchitectureSubject<NSNumber>, defaultValue: Int = 0) {
        super.init(architectureSubject: architectureSubject, defaultValue: defaultValue, toMapper: { $0.intValue }, fromMapper: { NSNumber(value: $0) })
    }
}

class FloatCombineSubject : CombineSubject<Float, NSNumber> {
    init(architectureSubject: ArchitectureSubject<NSNumber>, defaultValue: Float = 0) {
        super.init(architectureSubject: architectureSubject, defaultValue: defaultValue, toMapper: { $0.floatValue }, fromMapper: { NSNumber.init(value: $0) })
    }
}

class DoubleCombineSubject : CombineSubject<Double, NSNumber> {
    init(architectureSubject: ArchitectureSubject<NSNumber>, defaultValue: Double = 0) {
        super.init(architectureSubject: architectureSubject, defaultValue: defaultValue, toMapper: { $0.doubleValue }, fromMapper: { NSNumber.init(value: $0) })
    }
}

class BoolCombineSubject : CombineSubject<Bool, NSNumber> {
    init(architectureSubject: ArchitectureSubject<NSNumber>, defaultValue: Bool = false) {
        super.init(architectureSubject: architectureSubject, defaultValue: defaultValue, toMapper: { $0.boolValue }, fromMapper: { NSNumber.init(value: $0) })
    }
}
