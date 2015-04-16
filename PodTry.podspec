#
# Be sure to run `pod lib lint Demo.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PodTry"
  s.version          = "0.0.1"
  s.summary          = "This is a Simple Demo Library"
  s.description      = "This library is to check how a simple demo project would work with private pod spec and source pointing to the private pod spec"
  s.homepage         = "https://github.com/iamnpr/PodTry.git"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Naveen Prasad Raja" => "iamnpr@outlook.com" }
  s.source           = { :git => "https://github.com/iamnpr/PodTry.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/iamnpr'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'PodTry/PodTry/**/*'
  s.resource_bundles = {
    'Demo' => ['PodTry/PodTry/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
