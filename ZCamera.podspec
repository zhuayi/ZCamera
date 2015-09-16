#
# Be sure to run `pod lib lint ZCamera.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZCamera"
  s.version          = "1.0.1"
  s.summary          = "ZCamera是一款仿微信的相机和图片选择控件"


  s.description      = <<-DESC
                        ZCamera是一款仿微信的相机和图片选择控件,简单集成,高效性能.
                       DESC

  s.homepage         = "https://github.com/zhuayi/ZCamera"
  s.license          = 'MIT'
  s.author           = { "zhuayi" => "2179942@qq.com" }
  s.source           = { :git => "https://github.com/zhuayi/ZCamera.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ZCamera' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'MWPhotoBrowser', '2.1.1'
  s.dependency 'ZComponent/ZBaseViewController', '0.1.0'
  s.dependency 'ZComponent/Category', '0.1.0'
  s.dependency 'ZComponent/ZMacro', '0.1.0'
end
