#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'umeng_share'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new UMengShare plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.resource_bundles = {
      'umeng_share' => ['Assets/*.xcassets']
  }
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  # 集成微信(完整版14.4M)
  s.dependency 'UMCShare/Social/WeChat'
  # 集成QQ/QZone/TIM(精简版0.5M)
  s.dependency 'UMCShare/Social/ReducedQQ'
  s.dependency 'UMCShare/Social/ReducedQQ'
  s.dependency 'Masonry'
  s.dependency 'Toast'




  s.static_framework = true

  s.ios.deployment_target = '8.0'
end

