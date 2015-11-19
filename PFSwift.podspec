Pod::Spec.new do |s|
  s.name                    = 'PFSwift'
  s.version                 = '0.0.6'
  s.summary                 = '对系统API进行简单封装，实现常用功能'
  s.homepage                = 'https://github.com/PFei-He/PFSwift'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'PFei-He' => '498130877@qq.com' }
  s.platform                = :ios, '8.0'
  s.ios.deployment_target   = '8.0'
  s.source                  = { :git => 'https://github.com/PFei-He/PFSwift.git', :tag => s.version }
  s.requires_arc = true

  s.subspec 'Extension' do |ss|
    ss.source_files = 'PFSwift/PF{Date,String,View}.swift'
  end

  s.subspec 'Framework' do |ss|
    ss.source_files = 'PFSwift/PF{File,Model,QRCode,Scanner,Time}.swift'
  end
end
