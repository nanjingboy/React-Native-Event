Pod::Spec.new do |s|
  s.name             = 'ReactEventEmitter'
  s.version          = '0.1.0'
  s.summary          = 'React Native event emitter wrapper on both Android & iOS.'
  s.homepage         = 'https://github.com/nanjingboy/React-Native-Event'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tom.Huang' => 'hzlhu.dargon@gmail.com' }
  s.source           = { :git => 'https://github.com/nanjingboy/React-Native-Event', :tag => s.version.to_s }
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.source_files = "src/*.{h,m}"
  s.dependency 'React'
end