# project 13 - instafilter
Using UIImagePickerController and UISlider and some Core Image
## building the interface
- create a new single view app
- embed the view controller inside a navigation controller
- drag a `UIView` into the controller
- give the new view a width of 375 and height of 470, with X:0 and Y:64
- give the view the background color "Dark Gray Color"
- create an image view, and place it inside the view you just created
- indent it by 10 points on every side – i.e., width 355, height 450, X:10, Y:10
- change the image's view mode from "Scale to fill" to "Aspect Fit"
- creating a label with width 72, height 21, X:16, Y:562
- give it the text "Intensity" and make it right-aligned
- drop a slider next to it, giving it width 262, X:96, Y:558
- add a button 120 wide and 44 high, with X:16, Y:605
- give it the title "Change Filter"
- add a button 60 wide by 44 high, with X:300, Y:605
- give it the title "Save"
- click on "View Controller" in the document outline
- Editor > Resolve Auto Layout Issues > Reset To Suggested Constraints
- add an outlet for the image view and the slider, called respectively imageView and intensity
- create actions from the two buttons, calling methods changeFilter() and save()
- create an action from the slider with "Value Changed" event
- call the action's method intensityChanged()
## importing a picture

