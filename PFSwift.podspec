Pod::Spec.new do |s|
  s.name                    = 'PFSwift'
  s.version                 = '0.1.5'
  s.summary                 = '对系统API进行简单封装，实现常用功能'
  s.homepage                = 'https://github.com/PFei-He/PFSwift'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'PFei-He' => '498130877@qq.com' }
  s.platform                = :ios, '8.0'
  s.ios.deployment_target   = '8.0'
  s.source                  = { :git => 'https://github.com/PFei-He/PFSwift.git', :tag => s.version }
  s.source_files            = 'PFSwift/PF{Date,Dictionary,File,Model,QRCode,Scanner,String,Time,Timer,View}.swift'
  s.requires_arc            = true
end
