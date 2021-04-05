platform :ios, '11.0'
use_frameworks!

#turn off xcode warnings for pods
inhibit_all_warnings!

def included_pods

pod 'Google-Mobile-Ads-SDK'
pod 'MKRingProgressView'
pod 'Firebase/Analytics'
pod 'Firebase/Auth'	
pod 'Firebase/Core'
pod 'Firebase/Firestore'
pod 'FBSDKLoginKit'
pod 'GoogleSignIn'

end

target 'DragonOdyssey' do
  included_pods
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
           config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
           config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
           config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
       end
   end
end