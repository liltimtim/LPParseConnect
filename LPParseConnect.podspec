Pod::Spec.new do |s|
  s.name             = 'LPParseConnect'
  s.version          = '0.1.0'
  s.summary          = 'Connector for Parse LP Server'

  s.description      = 'Connect to Parse easily'

  s.homepage         = 'https://github.com/liltimtim/LPParseConnect'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liltimtim' => 'tim@launchpeer.com' }
  s.source           = { :git => 'https://github.com/liltimtim/LPParseConnect.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'

  s.source_files = 'LPParseConnect/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LPParseConnect' => ['LPParseConnect/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UserNotifications'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'Parse'
    s.dependency 'SwiftValidator'
end
