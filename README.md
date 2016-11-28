## Setup

### Install Submodules

The project uses submodules, so go ahead and call `git submodule update --init --recursive` to get the TDKit. If you don't have access, request it from the team. This is a prerequisite.


### Downgrade Cocoapods

If you have CocoaPods installed, you will most likely need to install 0.39.0 seperately which can be done by doing `sudo gem install cocoapods -v 0.39.0` and once this is installed, to use install the pods, you can execute `pod _0.39.0_ install` and step one is complete.

#### Why?
This repository uses CocoaPods 0.39.0 which has now become officially unsupported by the CocoaPods team. If you try and access the master repository using 0.39.0 you get told off. The Podfile uses the archived PodSpecs. This is a *workaround* - it needs upgrading to CocoaPods 1.0.0+ whenever possible.


### Install mogenerator
The project uses a tool called mogenerator to help with CoreData. To get this, execute: `brew install mogenerator`



### Install Crashlytics
One final dependency! Install crashlytics : https://fabric.io/downloads/xcode


