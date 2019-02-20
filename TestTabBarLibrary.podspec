Pod::Spec.new do |s|
  s.name             = 'TestTabBarLibrary'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TestTabBarLibrary.'
  s.homepage         = 'https://github.com/lukile/TestTabBarLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'lukile' => 'lucile.1988.ls@gmail.com' }
  s.source           = { :git => 'https://github.com/lukile/TestTabBarLibrary.git', :tag => "v#{s.version}"  }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = 'TestTabBarLibrary/Classes/**/*'
  s.swift_version = '4.2'
end
