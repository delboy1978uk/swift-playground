# project 6 
- copy project 2 into project 6a folder
Supported orientations can be checked/unchecked in main project settings.
- select bottom flag, ctrl drag to white space below
- choose Bottom Space to Safe Area
- in tree view click on safe area.bottom constraint
- change relation from equal to Greater Than or Equal
- change constant value to 20
- select the second button, ctrl-drag to the first
- choose equal heights
- do equal heights again from third to second
- ctrl drag each flag to itself
- choose aspect ratio 
## visual format language
- crearte new project 6b
- add to viewDidLoad()
```swift
let label1 = UILabel()
    label1.translatesAutoresizingMaskIntoConstraints = false
    label1.backgroundColor = UIColor.red
    label1.text = "THESE"
    label1.sizeToFit()

    let label2 = UILabel()
    label2.translatesAutoresizingMaskIntoConstraints = false
    label2.backgroundColor = UIColor.cyan
    label2.text = "ARE"
    label2.sizeToFit()

    let label3 = UILabel()
    label3.translatesAutoresizingMaskIntoConstraints = false
    label3.backgroundColor = UIColor.yellow
    label3.text = "SOME"
    label3.sizeToFit()

    let label4 = UILabel()
    label4.translatesAutoresizingMaskIntoConstraints = false
    label4.backgroundColor = UIColor.green
    label4.text = "AWESOME"
    label4.sizeToFit()

    let label5 = UILabel()
    label5.translatesAutoresizingMaskIntoConstraints = false
    label5.backgroundColor = UIColor.orange
    label5.text = "LABELS"
    label5.sizeToFit()        

    view.addSubview(label1)
    view.addSubview(label2)
    view.addSubview(label3)
    view.addSubview(label4)
    view.addSubview(label5)
```
- run app, note all are positioned overlapping at top left
- create dictionary of labels and add to viewDidLoad()
```swift
let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
for label in viewsDictionary.keys {
    view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
}
```
- add vertical constraints
```swift
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
```
- run the app, notice what it looks like, then replace that last line, paste this in, and notice the difference
```swift
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))
```
(==88) for the labels, and (>=10) for the space to the bottom. Note that when specifying the size of a space, you need to use the - before and after the size: a simple space, -, becomes -(>=10)-.
- refactor, so the height is one variable
```swift 
let metrics = ["labelHeight": 88]
```
and replace that line again
```swift
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
``` 
- run the app, and cmd-right-arrow to rotate device. note how top and bottom are ok but bottom one overlaps other labels
- make the first label use labelHeight at a priority of 999, replace that line again
```swift
""V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|"
```
## auto layout anchors
- comment out the existing layout code and replace it with thius:
```swift
var previous: UILabel?

for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true

    if let previous = previous {
        // we have a previous label – create a height constraint
        label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
    }

    // set the previous label to be the current one, for the next loop iteration
    previous = label
}}
```
