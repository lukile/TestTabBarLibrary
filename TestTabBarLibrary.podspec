Pod::Spec.new do |s|
  s.name             = "TestTabBarLibrary"
  s.version          = "1.0.38"
  s.summary          = "TestTabBarLibrary is Tab Bar project created for simplify the creation and integration of Tab Bar item."
  s.description      = "This project will allow developper to integrate a Tab Bar into their own project. They can define the color, the number of items (and their width), if they want to have a search view or not, if they want their Tab Bar to be at the top, the bottom, the right or the left of the screen. And if they want to much items for the screen, a 'more' item will allow them to access the items that cannot be directly on the Tab Bar."
  s.homepage         = 'https://github.com/lukile/TestTabBarLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'lukile' => 'lucile.1988.ls@gmail.com' }
  s.source           = { :git => 'https://github.com/lukile/TestTabBarLibrary.git', :tag => "#{s.version}"  }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = "TestTabBar/**/*.{swift,h}"
  s.swift_version = '4.2'
  s.framework    = 'SnapKit'
end
