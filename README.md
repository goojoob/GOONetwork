# GOONetwork
`GOONetwork` is a small library that provides a convenient way to decode JSON from a URL using the `decodeJSON` method.

<br/>

## ⚙️ Installation

#### Setup with Swift Package Manager

* In Xcode select *File > Add Packages*.
* Enter this project's URL: https://github.com/goojoob/GOONetwork.git

<br/>

## 👨‍💻 Compatibility

* macOS 12+
* iOS 13.0+
* Xcode 12.0+

<br/>

## 🔧 Usage

_To use `GOONetwork`, import the library in your code:_

```swift
import Foundation
import GOONetwork
```

_The `decodeJSON` method is available on the `GOONetwork` struct. It has the following signature:_

```swift
public struct GOONetwork {
  static public func decodeJSON<T: Decodable>(fromUrl: String) async throws -> T?
}
```

_To use `decodeJSON`, pass the URL of the JSON you want to decode as a string to the fromUrl parameter. The `decodeJSON` method returns a decoded optional object of type T asynchronously._

```swift
struct Product: Decodable {
    let title: String
    let description: String
}
let jsonUrl = "https://example.com/data.json"
let decodedObject: Product? = try await GOONetwork.decodeJSON(fromUrl: jsonUrl)
```

<br/>

## ⛔ Error Handling

The `decodeJSON` method throws an error if something goes wrong during the decoding process. The following errors can be thrown:

* `NetworkError.urlError`: This error is thrown if the provided URL is not valid.
* `NetworkError.responseError`: This error is thrown if the HTTP response status code is not 200.
* `NetworkError.dataError`: This error is thrown if there is an error getting the data from the provided URL.
* `NetworkError.decodeError`: This error is thrown if there is an error decoding the JSON.

_You can catch these errors using a catch block in your code. For example:_

```swift
do {
  let decodedObject: Product? = try await GOONetwork.decodeJSON(fromUrl: jsonUrl)
} catch let err as NetworkError {
  // Handle the error here
}
```

<br/>

## 🛠️ Created with

* [XCode 14.1](https://developer.apple.com/xcode/)
* [Swift 5.7.1](https://swift.org/)

<br/>

## ✒️ Author

<img src ="https://goojoob.dev/images/logo.svg" width=30 /> **Goojoob.dev** - *Original development* - [goojoob](https://twitter.com/goojoobdev) 

<br/>

## 📄 License

<a rel="license" target="_blank" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International license (CC BY 4.0)</a>.

<br/>

## 🎁 Thank You

* Talk to others about this project 📢
* We can have a ☕ whenever you want

<br/>
