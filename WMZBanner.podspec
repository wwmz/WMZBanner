Pod::Spec.new do |s|

  s.name         = "WMZBanner"
  s.version      = "1.2.0"
  s.platform     = :ios, '8.0'
  s.license      = "Copyright (c) 2018年 WMZ. All rights reserved."
  s.summary      = "轻量级轮播图,支持自定义内容和自定义卡片样式,支持网络图片和本地图片混合使用"
  s.description  = <<-DESC 
                    轻量级
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZBanner"
  s.license      = {:type => "MIT", :file => "LICENSE" }
  s.author       = { "wmz" => "925457662@qq.com" }
  s.source       = { :git => "https://github.com/wwmz/WMZBanner.git",:tag => s.version.to_s}
  s.source_files = "WMZBanner/WMZBanner/**/*.{h,m}"
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  s.frameworks   = 'UIKit','Foundation'
  s.dependency  'SDWebImage'
end


