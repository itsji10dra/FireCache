#
# Be sure to run `pod lib lint FireCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FireCache'
  s.version          = '0.1.0'
  s.summary          = 'Swift network and caching library.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
FireCache is a networking library that fetches and caches images, JSON, string via HTTP in Swift.
                       DESC

  s.homepage         = 'https://github.com/itsji10dra/FireCache'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jitendra' => 'itsji10dra@gmail.com' }
  s.source           = { :git => 'https://github.com/itsji10dra/FireCache.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/itsji10dra'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FireCache/Classes/**/*'
  s.swift_version = '4.2'
  
  # s.resource_bundles = {
  #   'FireCache' => ['FireCache/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
