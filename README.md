# tvOS vs iOS

[![Swift Version][swift-image]][swift-url]
![platforms]
[![License][license-image]][license-url]

This repository is part of [NSCoder Night Madrid](https://nscoder-mad.tumblr.com) Talk "tvOS vs iOS".

The repository include:

- Talk Slides.
- Initial Project
- Final Project

The sample project is a simple app that has several focus challenges focus management we can find when deloping for tvOS . It contains a Tabbar with three controllers:

- Buttons

- TestFields

- Collections

The final project show cases of:

- Select preference to element to get focus.

- Move the focus between 2  non-adjacent elements. (UIFocusGuide)

- Converting a view to focusable.

- Use of TVCardView.

- Focus management in Collections.

- Input test in tvOS and more .......

The app must be tested AppleTv

## Usage

The api used is [unsplash](https://unsplash.com)
In order to test sample projects yout need an access key. Your can register and create a free new one on [Join Unsplash](https://unsplash.com/join)

To test initial project just replace the placeholder in class UnsplashRequestBuilder of SPM UnsplashApi:

```swift
private letapiKeyUnplash = "UNSPLASH ACCESS KEY"
```

To test final sample project, the slides information maybe is useful. It contains explained each property and function used to focus management.

## Note

Use UIkit for interfave, SwiftUI version will be added soon.

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Authors

- [@pmunoz08](https://www.github.com/pmunoz08)

## 🚀 About Me

I'm a iOS, tvOS and MacOS freelance developer since 2011

[swift-image]:https://img.shields.io/badge/swift-6.0-orange.svg
[swift-url]: https://swift.org/
[platforms]: https://img.shields.io/badge/platforms-itvOS-oreen
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
