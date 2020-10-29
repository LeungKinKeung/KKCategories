Pod::Spec.new do |s|
  s.name             = 'KKCategories'
  s.version          = '1.0'
  s.summary          = 'KKCategories.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LeungKinKeung/KKCategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LeungKinKeung' => 'leungkinkeung@qq.com' }
  s.source           = { :git => 'https://github.com/LeungKinKeung/KKCategories.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'KKCategories/**/*'
  
end
