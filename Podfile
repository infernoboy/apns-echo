platform :ios, '11.0'
use_frameworks!

post_install do |installer|
	installer.pods_project.build_configurations.each do |config|
		config.build_settings.delete('CODE_SIGNING_ALLOWED')
		config.build_settings.delete('CODE_SIGNING_REQUIRED')
	end
end


target 'APNS Echo' do
	pod 'Alamofire'
end

