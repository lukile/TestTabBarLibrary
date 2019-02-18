Pod::Spec.new do |spec|
  s.name             = 'TestTabBarLibrary'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TestTabBarLibrary.'
  s.description      = <<-DESC
  s.homepage         = 'https://github.com/lukile/TestTabBarLibrary'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lukile' => 'lucile.1988.ls@gmail.com' }
  s.source           = { :git => 'https://github.com/lukile/TestTabBarLibrary.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'TestTabBarLibrary/Classes/**/*'
end
