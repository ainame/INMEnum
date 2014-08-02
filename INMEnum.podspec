#
# Be sure to run `pod lib lint INMEnum.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "INMEnum"
  s.version          = "0.1.1"
  s.summary          = "INMEnum provide defining method to create a enum object as a plain old objc object."
  s.description      = <<-DESC
                       INMEnum provide defining method to create a enum object as a plain old objc object.
                       This almost realize the enum object like Java lang's one.
                       DESC
  s.homepage         = "https://github.com/ainame/INMEnum"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "ainame" => "s.namai.2012@gmail.com" }
  s.source           = { :git => "https://github.com/ainame/INMEnum.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ainame'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  # s.resources = 'Pod/Assets/*.png'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
