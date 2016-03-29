NFP One Fader
=============

This is a simple Mac application that can be configured as a fader control for any number of channels on a [Pathway Connectivity](http://www.pathwayconnect.com) [Network Fade Processor](http://www.pathwayconnect.com/content/view/216/29/).  Using the plist file you can configure the channels and the IP address of the NFP.  It will fade between 0 and 100% (0 and 255).  This application requires OS X 10.9 or newer.

#### To Build

* Download and install XCode 7.2 or later
* Clone this Repository
* Enter the directory you cloned the repository to
* Install Carthage [Carthage](https://github.com/Carthage/Carthage)
* Run `carthage build` in the root directory of the application
* Open and build in Xcode


#### TODOS

* Add preferences to the application for the NFP address and channels
* Add [Sparkle](https://sparkle-project.org) for application updates.
