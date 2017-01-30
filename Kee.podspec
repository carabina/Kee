Pod::Spec.new do |s|
    s.name                  = 'Kee'
    s.module_name           = 'Kee'

    s.version               = '1.0.0'

    s.homepage              = 'https://github.com/maxsokolov/Kee'
    s.summary               = 'Generic key value storage.'

    s.author                = { 'Max Sokolov' => 'https://twitter.com/max_sokolov' }
    s.license               = { :type => 'MIT', :file => 'LICENSE' }
    s.platforms             = { :ios => '8.0' }
    s.ios.deployment_target = '8.0'

    s.source_files          = 'Sources/*.swift'
    s.source                = { :git => 'https://github.com/maxsokolov/Kee.git', :tag => s.version }
    s.dependency 'KeychainAccess', '~> 3.0'
end