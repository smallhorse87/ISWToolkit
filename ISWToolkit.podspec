#
# Be sure to run `pod lib lint ISWToolkit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ISWToolkit'
  s.version          = '0.1.2'
  s.summary          = '开发这么多年也就留下这些精华了ISWToolkit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/smallhorse87/ISWToolkit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'smallhorse87' => 'smallhorse87@163.com' }
  s.source           = { :git => 'https://github.com/smallhorse87/ISWToolkit', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ISWToolkit/Classes/**/*'

  # s.resource_bundles = {
  #   'ISWToolkit' => ['ISWToolkit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MJRefresh'
  s.dependency 'LCActionSheet'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'DRPLoadingSpinner'
  s.dependency 'JKCountDownButton'
  s.dependency 'SDCycleScrollView', '~> 1.65'
  s.dependency 'SDWebImage', '~> 3.7.6'
  s.dependency 'MBProgressHUD'

  non_arc_files = "ISWToolkit/Classes/OpenUDID/*.{h,m}"
  s.exclude_files = non_arc_files

  s.subspec 'no-arc' do |sp|
   sp.requires_arc = false
   sp.source_files = non_arc_files
  end

end
