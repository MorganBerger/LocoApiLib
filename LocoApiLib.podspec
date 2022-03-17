#
# Be sure to run `pod lib lint LocoApiLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LocoApiLib'
  s.version          = '0.1.3'
  s.summary          = 'A light SwiftUI lib for handling translations with localise.bis API.'

  s.description      = <<-DESC

  This small piece of code allows you to download all the localisables for your app (preferably at launch) and change the app language during runtime.
  It will only work product using SwiftUI for now.
  - Minimun iOS version requiered: iOS 13.0
  - Swift 4.0+
  
  DESC


  s.homepage         = 'https://github.com/morganberger/LocoApiLib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'morganberger' => 'morgan.berger71@gmail.com' }
  s.source           = { :git => 'https://github.com/morganberger/LocoApiLib.git', :tag => s.version.to_s }

  s.swift_versions = "4.0"
  
  s.ios.deployment_target = '13.0'


  s.source_files = 'LocoApiLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LocoApiLib' => ['LocoApiLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'SwiftUI'
  # s.dependency 'AFNetworking', '~> 2.3'
end
