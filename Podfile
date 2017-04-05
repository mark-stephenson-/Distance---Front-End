# Master Pods Repo
source 'https://github.com/CocoaPods/Specs.git'

# Private Pods Repo
#source 'git@bitbucket.org:thedistance/thedistancekit-cocoapods.git'

# pod configuration
platform :ios, '9.3'
inhibit_all_warnings!
use_frameworks!

# define
workspace 'NHS Prase'
project 'NHS Prase'

# define groups of pods

def distribution
    pod 'GoogleAnalytics'
    pod 'Fabric'
    pod 'Crashlytics'
end

def core
	pod 'MagicalRecord'
	pod 'AFNetworking'
	pod 'MBProgressHUD'
end

def thedistance
	pod 'TheDistanceKit/TheDistanceKit_API', :path => "TDKit"
end


# set pods for each target

target 'NHS Prase' do

    distribution
	core
	thedistance
    
end

target 'NHS PraseTests' do
	core
	thedistance
	pod 'KIF'	
    
end

