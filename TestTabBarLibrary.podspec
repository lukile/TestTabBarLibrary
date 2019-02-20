Pod::Spec.new do |s|
  s.name             = "TestTabBarLibrary"
  s.version          = "1.0.0"
  s.summary          = "TestTabBarLibrary is Tab Bar project created for simplify the creation and integration of Tab Bar item."
  s.description      = "This project will allow developper to integrate a Tab Bar into their own project. They can define the color, the number of items (and their width), if they want to have a search view or not, if they want their Tab Bar to be at the top, the bottom, the right or the left of the screen. And if they want to much items for the screen, a 'more' item will allow them to access the items that cannot be directly on the Tab Bar."
  s.homepage         = "https://github.com/lukile/TestTabBarLibrary"
  s.license          = { :type => "BSD", :file => "LICENSE" }
  s.author           = { "lukile" => "lucile.1988.ls@gmail.com" }
  s.source           = { :git => "https://github.com/lukile/TestTabBarLibrary.git", :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'TestTabBarLibrary/Classes/**/*'
  s.swift_version = '4.2'
end
