Pod::Spec.new do |s|
  s.name                    = 'PFSwift'
  s.version                 = '0.0.2'
  s.summary                 = '对系统API进行简单封装，实现常用功能'
  s.homepage                = 'https://github.com/PFei-He/PFSwift'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'PFei-He' => '498130877@qq.com' }
  s.platform                = :ios, '8.0'
  s.ios.deployment_target   = '8.0'
  s.source                  = { :git => 'https://github.com/PFei-He/PFSwift.git', :tag => s.version, :submodules => true }
  s.requires_arc = true

  s.subspec 'Extension' do |ss|
    ss.source_files = 'PFSwift/Extension/PF{String,View}.swift'
  end

  s.subspec 'Framework' do |ss|
    ss.source_files = 'PFSwift/Framework/PF{File,Model,QRCode,Time}.swift'
  end
end
