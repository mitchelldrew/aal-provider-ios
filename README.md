# aal-provider-ios

Platform specific REST and I/O classes for [Alltrails At Lunch IOS](https://github.com/mitchelldrew/aal-app-ios), implemented from [presenter](https://github.com/mitchelldrew/aal-presenter) interfaces.

To build for release, provider must be supplied with a release version of [presenter](https://github.com/mitchelldrew/aal-presenter). Once supplied, target arm64 and select Product > Archive. The release provider artifact must then replace the debug provider artifact in [Alltrails At Lunch](https://github.com/mitchelldrew/aal-app-ios) before that project will generate an .abi.
