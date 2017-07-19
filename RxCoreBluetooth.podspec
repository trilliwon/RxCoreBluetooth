Pod::Spec.new do |s|
  s.name             = 'RxCoreBluetooth'
  s.version          = '0.0.1'
  s.summary          = 'RxCoreBluetooth is a CoreBluetooth Extension for RxSwift'

  s.description      = 'RxCoreBluetooth is a CoreBluetooth Extension for RxSwift. It contains CoreBluetoth funtionalities.'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0'
  }
  s.homepage         = 'https://github.com/trilliwon/RxCoreBluetooth'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'trilliwon' => 'trilliwon@gmail.com' }
  s.source           = { :git => 'https://github.com/trilliwon/RxCoreBluetooth.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/trilliwon'

  s.ios.deployment_target = '10.0'
  s.source_files = 'Sources/*'
  s.dependency 'RxSwift', '~> 3.0'
  s.dependency 'RxCocoa', '~> 3.0'

end
