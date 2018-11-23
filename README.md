# FireCache
##### A Swift Networking Library

FireCache is a networking library that fetches and caches images, JSON, string via HTTP in Swift and is flexible to be extended to custom types.

## Features

- In-memory caching.
- Nonblocking IO. All HTTP and IO happen in the background.
- Fully Generic.
- Simple extension method for UIImageView to load a remote image.
- Robust, fast and fully-customizable.
- Simple, easy-to-understand and concise codebase.
- handles redundant image requests smartly.

## Requirements

Requires at least iOS 8 or above.

## Installation

#### CocoaPods

FireCache requires CocoaPods 1.1.x or higher.

FireCache is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'FireCache'
```

## Example

First thing is to import the framework.

```swift
import FireCache
```

Once imported, you can start requesting images.

```swift
//you can simply call the URL string on your UIImageView
let imageUrl = URL(string: "https://www.example.com/sample.png")!
let imageView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
self.imageView.setImage(with: imageUrl)

//Fetch image using the FireCache Image Manager
FireImageManager.shared.fetch(with: url) { (image, url, error) in
  //Returns `url`
  //Returns either of `image` or `error`
}
```

## Downloading JSON using FireCache
Using default JSON Manager.
```swift
FireJSONManager.shared.fetch(with: url) { (json, url, error) in
  //Returns `url`
  //Returns either of `json` or `error`
}
```

## Cancel Request
Fetched requests can be cancelled when needed. This causes the closures to be called throwing error with error code `NSURLErrorCancelled`.
```swift
let downloadTask = self.imageView.setImage(with: imageUrl)
downloadTask?.cancel()
```

## Downloading Custom Type with FireManager 
You can create your own type for caching with FireCache. Let's consider new type as `ZIP`.
```swift
//Extend you type with `Cacheable` protocol
extension ZIP: Cacheable {
  public typealias Object = ZIP
  public static func convertFromData(_ data: Data) throws -> ZIP {
  guard let zip = ZIP(data: data) else { throw FireError.invalidData }
    return zip
  }
}

let fireZIPManager = FireManager<ZIP>()
fireZIPManager.fetch(with: url) { (zip, url, error) in
  //Returns `url`
  //Returns either of `zip` or `error`
}
```

## Prioritise Task
```swift
let task1 = fireManager.fetch(with: url) { (file, url, error) in }
let task2 = fireManager.fetch(with: url) { (file, url, error) in }
let task3 = fireManager.fetch(with: url) { (file, url, error) in }

task1?.priority = 0.2
task2?.priority = 0.5
task3?.priority = 1.0
```

## License

FireCache is licensed under MIT Open source license.

## Contact

### Jitendra Gandhi
###### An Immature Programmer
* http://itsji10dra.com/
* https://github.com/itsji10dra
* http://twitter.com/itsji10dra
* https://www.linkedin.com/in/itsji10dra/
* https://stackoverflow.com/users/story/2713079/

