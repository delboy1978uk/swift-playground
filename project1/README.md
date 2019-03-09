# project 1
Listing Files, making an image viewing app
## setting up
- Create ne Xcode project
- single view app, next
- project 1 for product name, swift for language, universal for devices
- org identifier (reversed wesite domain)
- leave use core data, unit tests, and ui tests unchecked for now
- project > destinatin (or icon top left) select device to test on (my phone!)
- cmd-r to run, cmd-. to stop (or use the icons)
- create Content folder with images, drag into project
- check 'copy items if needed' choose create groups
- click finish!
## listing images
- open viewcontroller.swift
- add code to viewDidLoad func (see actual code)
## designing the interface
- change ViewController, get it to extend UITableViewController
- go into main storyboard
- make sure document outline is on - editor menu
- select view controller scene and delete it!
- open objecrt library (cmd-shift-L, or View > Libraries > Show Library)
- type table to search
- drag TableViewController onto storyboard
- open identity inspector (cmd-alt-3 or View > Utilities > Show Identity Inspector)
- where it says class, select ViewController
- open attributes inspector (cmd-alt-4 or View > Utilities > Show Attributes Inspector)
- check Is Initial View Controller
- in document outline drill down tree to table view with cell inside
- select cell, attributes inspector, enter "Picture" into identifier
- change style from custom to basic
- 
