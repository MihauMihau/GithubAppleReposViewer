# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target 'GitHubReposViewer' do

pod 'Alamofire', '~> 4.0'
pod 'PKHUD', :git => 'https://github.com/toyship/PKHUD.git'
pod 'Kingfisher', '~> 3.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
