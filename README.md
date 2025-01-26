# CurrencyExchange
Test App to track currency exchange rate and manage your favorites || build with UIKit framework.

- Clone the repository -> install cocoapods (pod install) -> open .xcworkspace file.
- MVVM architecture - View displayed currency list, ViewModel - Retrieve data from api or keychain and prepare it for view, Model - Represent the data.
- Navigation build with coordinator pattern, APIClient and Alamofire library for api requests, Keychain library for secure storing the data, SnapKit to build ui via code.
- Stores favorite currencies and allList currencies securely in the Keychain, users can access saved rates even without an internet connection, syncs with the server once online.
- SnapKit, Alamofire, KeychainSwift (explained in 3rd point)

