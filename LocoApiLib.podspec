#
# Be sure to run `pod lib lint LocoApiLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LocoApiLib'
  s.version          = '0.1.0'
  s.summary          = 'A light SwiftUI lib for handling translations with localise.bis API'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A longer description of the current project yo. Not long enough. Still not. Should be okay now.'

  s.homepage         = 'https://github.com/morganberger/LocoApiLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'morganberger' => 'morgan.berger71@gmail.com' }
  s.source           = { :git => 'https://github.com/morganberger/LocoApiLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_versions = "5.0"
  
  s.ios.deployment_target = '9.0'

  
  s.source_files = 'LocoApiLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LocoApiLib' => ['LocoApiLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
