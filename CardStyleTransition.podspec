#
# Be sure to run `pod lib lint CardTransition.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CardStyleTransition'
  s.version          = '0.1.4'
  s.summary          = 'UI component which presents a view controller as a Card'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                UI component which presents a view controller as a Card dismisseable by swipping down
                       DESC

  s.homepage         = 'https://github.com/AlbGarciam/CardTransition.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alb.garciam@gmail.com' => 'alb.garciam@gmail.com' }
  s.source           = { :git => 'https://github.com/AlbGarciam/CardTransition.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'CardTransition/Classes/**/*'
  s.swift_version = '5'
  
  # s.resource_bundles = {
  #   'CardTransition' => ['CardTransition/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
