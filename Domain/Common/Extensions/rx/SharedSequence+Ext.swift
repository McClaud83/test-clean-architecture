import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
  func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
    return map { _ in }
  }
}

extension SharedSequenceConvertibleType where Element == Bool {
  func not() -> SharedSequence<SharingStrategy, Bool> {
    return self.map(!)
  }
  
  func isTrue() -> SharedSequence<SharingStrategy, Bool> {
    return flatMap { isTrue in
      guard isTrue else {
        return SharedSequence<SharingStrategy, Bool>.empty()
      }
      return SharedSequence<SharingStrategy, Bool>.just(true)
    }
  }
}

extension SharedSequenceConvertibleType where Element: OptionalType {
  /**
   Unwraps and filters out `nil` elements.
   - returns: `SharedSequence` of source `SharedSequence`'s elements, with `nil` elements filtered out.
   */
  public func ignoreNil() -> SharedSequence<SharingStrategy, Element.Wrapped> {
    return flatMap { value in
      value.optional.map { SharedSequence<SharingStrategy, Element.Wrapped>.just($0) } ?? SharedSequence<SharingStrategy, Element.Wrapped>.empty()
    }
  }
}
