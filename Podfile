platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

target 'RXIMSdkDemo' do
    use_frameworks!
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
            end
        end
    end
    pod 'Protobuf'
    pod 'RXNetworkingKit','~>1.2.3.1'
    pod 'YYCache'
    pod 'YYModel'
    pod 'MJExtension'
    pod 'AliyunOSSiOS'
    pod 'SVProgressHUD'
    pod 'WCDB'  	
    #pod 'RXIMSDK-iOS'
    #调试工具
    pod 'DoraemonKit/Core', '~> 2.0.0', :configurations => ['Debug']
end


