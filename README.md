# CurrencyExchange
Test App to track currency exchange rates and manage your favorites, built with the UIKit framework.

- Clone the repository -> install CocoaPods (pod install) -> open the .xcworkspace file.
- MVVM architecture: View displays the currency list, ViewModel retrieves data from the API or Keychain and prepares it for the view, and Model represents the data.
- Navigation is built with the coordinator pattern. APIClient and the Alamofire library handle API requests, the Keychain library securely stores data, and SnapKit is used to build the UI via code.
- Stores favorite currencies and all currencies securely in the Keychain. Users can access saved rates even without an internet connection and sync with the server once online.
- SnapKit, Alamofire, and KeychainSwift (explained in the third point).

