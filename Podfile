# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'yahn' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for yahn
  pod 'HNScraper', :git => 'https://github.com/faizmokhtar/HNScraper.git', :branch => 'master'
  pod 'SwiftSoup'

  target 'yahnTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'yahnUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
      config.build_settings['ARCHS'] = '$(ARCHS_STANDARD_64_BIT)'
     end
  end
end
