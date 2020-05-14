import Foundation

protocol DIConfigurable {
  associatedtype Container
  init(container: Container)
}
