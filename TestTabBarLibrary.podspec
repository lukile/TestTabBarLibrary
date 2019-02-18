#
# Be sure to run `pod lib lint TestTabBarLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TestTabBarLibrary'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TestTabBarLibrary.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/lukile/TestTabBarLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'lukile' => 'lucile.1988.ls@gmail.com' }
  s.source           = { :git => 'https://github.com/lukile/TestTabBarLibrary.git', :tag => "v#{s.version}"  }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TestTabBarLibrary/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TestTabBarLibrary' => ['TestTabBarLibrary/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'Pod::Spec.new do |s|
  s.swift_version = '4.2'

end
