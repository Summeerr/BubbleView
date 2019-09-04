# Uncomment this line to define a global platform for your project
platform :ios,'8.0'
plugin 'cocoapods-repo-svn', :sources => [
    'http://200.200.200.40/svn/repositories/ios/code/trunk/HETPublicModuleSDK/HETModuleSpecs'
]
source 'https://github.com/CocoaPods/Specs.git'

post_install do |installer|
    use_ipub installer
end

def dependency_pods
  #组件所有的依赖库写在这里，只是Demo项目所需的请写在项目内，必须固定版本
  #外部(github等)第三方库使用       pod 'XXXX'
  #公司内部组件请使用               pod_ipub 'XXXX'
end

target 'HETSleepBubbleViewDemo' do
  #dependency_pods
  #只是Demo工程依赖的请写在此处
  # pod 'XXXXX'
end
target 'HETSleepBubbleView' do
  dependency_pods
end


#use_modular_headers!
inhibit_all_warnings!
