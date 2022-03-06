# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

def common_pods
  
  # RX Core
  pod 'RxSwift'
  pod 'RxCocoa'
  
  # RX Extension
  pod 'RxSwiftExt'
  pod 'RxAlamofire'
  pod 'RxGesture'
  pod 'RxAppState', '~> 1.1.2'

  # Mapper
  pod 'ObjectMapper'
  
  
  # Network
  pod 'Alamofire'
  pod 'AlamofireImage'
  
  # Image
  pod 'SDWebImage', '~> 5.0'

  # HTML parser
  pod 'SwiftSoup'

end


target 'github_search' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  common_pods

  # Pods for github_search

  target 'github_searchTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'github_searchUITests' do
    # Pods for testing
  end

end
