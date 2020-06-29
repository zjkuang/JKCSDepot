# JKCSDepot

## Publish A New Version
```$ git add .
$ git commit -m '<comments>'
$ git tag 'x.y.z'
$ git push origin master --tags
```
## Creating The New Swift Package JKCSDepot
ATTENTION! DUE TO THE ISSUE WITH Xcode, DO NOT OPEN THE NEW CREATED PACKAGE IN Xcode until STEP (6).  
(1) Create a new repository `JKCSDepot` on GitHub  
(2) Clone the new created GitHub repository `JKCSDepot` to the local directory  
(3) Create the new Swift package  
```$ cd path/to/JKCSDepot
$ swift package init
```
(4) In Finder, right click on Package.swift and open with an editor OTHER THAN Xcode, add iOS 13 to platforms and other Swift packages to dependencies  
```let package = Package(
    name: "JKCSDepot",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "JKCSDepot",
            targets: ["JKCSDepot"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "Reachability", url: "https://github.com/ashleymills/Reachability.swift.git", from: "4.3.1"),
        .package(name: "KeychainAccess", url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "JKCSDepot",
            dependencies: ["Reachability", "KeychainAccess"]),
        .testTarget(
            name: "JKCSDepotTests",
            dependencies: ["JKCSDepot"]),
    ]
)
```
(5) In terminal, NOT XCODE, build the package to make the revision of `Package.swift` take into effect  
```$ swift build
```
(6) In Finder, double click on `Package.swift` to open the package in Xcode. Change the target machine from `My Mac` to `Generic iOS Device`  
(7) Add files to the new created Swift package  
Sometimes copy-and-pasting files from another Swift package into the new created one will cause build error like `no such module 'UIKit'`. To fix this issue, in the auto-generated "Hello world" file, `JKCSDepot.swift` in this example, add `import UIKit` and build the package, then copy-and-pasting files from other Swift package will be OK.  
(8) Publish the package to GitHub  
