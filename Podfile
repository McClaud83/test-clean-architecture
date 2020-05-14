platform :ios, '11.0'
use_frameworks!

def rxSwift
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
end

def moya
  pod 'Moya/RxSwift'
end

def swinject
  pod 'Swinject'
end

target 'TestCleanA' do
  rxSwift
  swinject
  pod 'RxViewController'
  pod 'RxDataSources'
  pod 'SnapKit'
end

target 'Domain' do
  rxSwift
  swinject
end

target 'Data' do
  rxSwift
  swinject
  moya
  pod 'GoogleSignIn'
end
