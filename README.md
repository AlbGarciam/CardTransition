# CardStyleTransition
[![Version](https://img.shields.io/cocoapods/v/CardStyleTransition.svg?style=flat)](https://cocoapods.org/pods/CardStyleTransition)
[![License](https://img.shields.io/cocoapods/l/CardStyleTransition.svg?style=flat)](https://cocoapods.org/pods/CardStyleTransition)
[![Platform](https://img.shields.io/cocoapods/p/CardStyleTransition.svg?style=flat)](https://cocoapods.org/pods/CardStyleTransition)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
![](https://github.com/AlbGarciam/CardTransition/blob/master/animation.gif)

## Requirements
* iOS 10.0+
* Swift 5

## Installation

CardTransition is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CardStyleTransition'
```

## How to use

You only need to set your custom transition handler and conform to BottomOverlayprotocol. 

```swift
class SecondViewController: UIViewController, BottomOverlayProtocol {

    var transitionHandler : BottomOverlayTransitionHandler!

    init() {
        super.init(nibName: nil, bundle: nil)
        self.transitionHandler = BottomOverlayTransitionHandler(presented: self,
                                                                interactive: true,
                                                                dimmedColor: .blue,
                                                                indicatorColor: .yellow,
                                                                duration: 1)
        transitioningDelegate = transitionHandler
        modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    func bottomOverlayHeight() -> CGFloat {
        return 300
    }
    
    func bottomOverlayWidth() -> CGFloat {
        return min(UIScreen.main.bounds.width, 414 )
    }
}
```

By implementing `bottomOverlayHeight()` you can specify the height of the overlay. If you dont implement this method it will apply the minimum height that fits to the container

## Author

[AlbGarciam](https://github.com/AlbGarciam)

## License

CardStyleTransition is available under the MIT license. See the LICENSE file for more info.
