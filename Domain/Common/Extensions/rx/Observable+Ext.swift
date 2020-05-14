import Foundation
import RxSwift
import RxCocoa

public protocol OptionalType {
  associatedtype Wrapped
  
  var optional: Wrapped? { get }
}

extension Optional: OptionalType {
  public var optional: Wrapped? { return self }
}


extension ObservableType where Element == Bool {
  func not() -> Observable<Bool> {
    return self.map(!)
  }
}

extension ObservableType {
  
  func catchErrorJustComplete() -> Observable<Element> {
    return catchError { _ in
      return Observable.empty()
    }
  }
  
  func asDriverOnErrorJustComplete() -> Driver<Element> {
    return asDriver { error in
      return Driver.empty()
    }
  }
  
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
}

extension ObservableType where Element: OptionalType {
  public func ignoreNil() -> Observable<Element.Wrapped> {
    return flatMap { value in
      value.optional.map { Observable.just($0) } ?? Observable.empty()
    }
  }
}

extension ObservableType where Element: Collection {
  /// Ignores empty arrays
  public func ignoreEmpty() -> Observable<Element> {
    return flatMap { array in
      array.isEmpty ? Observable.empty() : Observable.just(array)
    }
  }
}
