Pod::Spec.new do |s|

  s.name         = "WMZBanner"
  s.version      = "1.0.0"
  s.license      = "Copyright (c) 2018年 WMZ. All rights reserved."
  s.summary      = "轻量级轮播图,支持自定义内容和自定义卡片样式,支持网络图片和本地图片混合使用"
  s.description  = <<-DESC 
                    轻量级
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZBanner"
  s.license      = {:type => "MIT", :file => "LICENSE" }
  s.author       = { "wmz" => "925457662@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/wwmz/WMZBanner.git",:tag => s.version.to_s}
  s.source_files = "WMZBanner/WMZBanner/**/*.{h,m}"
  s.framework = 'UIKit'
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.requires_arc = true  
end

