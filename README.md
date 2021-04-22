# Cats Arena
Cats Arena is an iOS Application designed for displaying the Cats pictures and its detail using the cats API.

Demo Video Link: **[Cats Arena - iOS ](https://www.youtube.com/watch?v=BrDw82aidjQ&ab_channel=HassanShahid)**
#### System Architecture:
This application was developed on Xcode IDE. Xcode is used for creating native iOS, watchOS, tvOS applications. Xcode does not generate the code for any application. The developer has to design the screens first and then connect the code with the design.

### Features:
This app has following major features:
1. Displaying the cats pictures with the breed name
2. Ability to add the image to favorites and remove it
3. Ability to filter cat breeds
4. Showing the details of the cat
5. Upload an image via camera and/or library
6. Object Mapper technique has been used for mapping API responses
7. Data Cache to present when the internet is not available
8. Pull to refresh (API Call)
9. Internet Connectivity Management
10. Unit Testing has been performed

**Models:**
1. CatsViewerAllCatsResponse (Array of All Cats)
2. CatsViewerFavouriteResponse (Array Favorites Cats)
3. CatsViewerBreedsResponse (Array of Cats Breeds)

**Views:**
1. Main.storyboard (where I have the UI Views designed)

**Controllers:**
1. FakeLaunchScreenVC (App first intro screen where I load the cache value)
2. TabBarMainVC (Where I added two View Controllers for using Tabbar)
3. HomeVC (Where all cats with breed name can be seen)
4. FavouriteVC (where we can see the favorites cats only)
5. CatsDetailVC (In this controller we can see the details of the cat)

**File Naming Conventions:**
* **VC** are ViewControllers
* **CCell** are CollectionViewCells
* **TCell** are TableViewCells

There is another folder in the app:
**Helpers:**
1. **Constants** (constants used in the app such as URLs)
2. **Extensions** (useful feature that helps in adding more functionality to an existing Class and written one time to access anywhere)
3. **ServerManager** (API calls)
4. **Globals** (Use to access the global variables)

App images are places in **Assets.xcassets** folder


### Cocoapods:

Cats Arena uses a number of open source 3rd Party Libraries for better user experience:

* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category. Indicator(Loader/Spinner)
* [Alamofire](https://github.com/Alamofire/Alamofire) - An HTTP networking library.
* [LoadingPlaceholderView](https://github.com/MarioIannotta/LoadingPlaceholderView) - Non-blocking animated gradient placeholder for tableview for your async tasks.
* [RappleProgressHUD](https://github.com/rjeprasad/RappleProgressHUD) - User-friendly and easy to use activity / progress indicator view.
* [LNFloatingActionButton](https://github.com/akaimo/LNFloatingActionButton) - LNFloatingActionButton is an easily customizable Floating Action Button.
* [SOTabBar](https://github.com/Ahmadalsofi/SOTabBar) - Custom tabbar controller.
* [DropDown](https://github.com/AssistoLab/DropDown) - A Material Design drop down for iOS written in Swift.
* [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) - An extension to Alamofire which automatically converts JSON response data into swift objects using ObjectMapper.
* [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper) - ObjectMapper is a framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON.
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - SwiftyJSON makes it easy to deal with JSON data in Swift.
* [DataCache](https://github.com/huynguyencong/DataCache) - This is a simple disk and memory cache. It can cache basic swift type

### Support:
In case of any errors or app crashes please email me at:

Hassan Shahid ( [hassan .shahid94@yahoo.com](hassan.shahid94@yahoo.com) )


----


**Last Updated: 23.04.2021**
