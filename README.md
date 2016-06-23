# ![Cordova-Plugin-Vuforia][logo]
Cordova-Plugin-Vuforia is a [Cordova][cordova] plugin that uses [Vuforia][vuforia] to perform image recognition.

You can see a live example in the [Peugeot 208][peugeot] app on iOS and Android and a basic open source example in the [cordova-vuforia-example][example-repo] repo.

[![NPM Version][shield-npm]][info-npm]
[![Supported Cordova Versions][shield-cordova]][info-npm]
[![Build Status][shield-travis]][info-travis]
[![Bithound Score][shield-bithound]][info-bithound]
[![License][shield-license]][info-license]


## Supported Platforms
Android (Minimum 4), iOS (Minimum 8)


## Requirements
Cordova-Plugin-Vuforia requires the following:
* [npm][npm]
* [Cordova 6.*][cordova] - 6.* is required as it adds support for Android 6 (Marshmellow) and iOS 9.
  * If you haven't yet installed the Cordova CLI, grab the latest version by following [these steps][install-cordova].
  * If you've already got a project running with an older version of Cordova (e.g. 4 or 5), [see here][updating-cordova] how to update your project's Cordova version.
  * Or if you want to upgrade to the latest version on a platform-by-platform basis, see either [upgrading to cordova-ios 4][upgrading-ios] or [upgrading to cordova-android 5][upgrading-android].

**NOTE:** You will require an Android or iOS device for development and testing. Cordova-Plugin-Vuforia requires hardware and software support that is not present in either the iOS or Android simulators.

## Getting Started
### Plugin Installation
```bash
cordova plugin add cordova-plugin-vuforia
```

#### JavaScript
Cordova-Plugin-Vuforia comes with two JavaScript methods, `startVuforia`, and `stopVuforia`. Below is an implementation for each.

##### `startVuforia` - Start your Vuforia session
From within your JavaScript file, add the following to launch the [Vuforia][vuforia] session.

```javascript
var options = {
  databaseXmlFile: 'PluginTest.xml',
  targetList: [ 'logo', 'iceland', 'canterbury-grass', 'brick-lane' ],
  overlayMessage: 'Point your camera at a test image...',
  vuforiaLicense: 'YOUR_VUFORIA_KEY'
};

navigator.VuforiaPlugin.startVuforia(
  options,
  function(data) {
    // To see exactly what `data` can return, see below.
    console.log(data);
    
    if(data.status.imageFound) {
      alert("Image name: "+ data.result.imageName);
    }
    else if (data.status.manuallyClosed) {
      alert("User manually closed Vuforia by pressing back!");
    }
  },
  function(data) {
    alert("Error: " + data);
  }
);
```

**NOTES:**
* You will need to replace `YOUR_VUFORIA_KEY` with a valid license key for the plugin to launch correctly.
* For testing you can use the `targets/PluginTest_Targets.pdf` file inside the plugin folder; it contains all four testing targets.

###### Return data API
`startVuforia` takes two callbacks - one for `success` and one for `faliure`. When `success` is called, a `data` object is passed to cordova:

**Image Found** - when an image has been successfully found, `data` returns:

```json
{
  "status": {
    "imageFound": true,
    "message": "Image found."
  },
  "result": {
    "imageName": "IMAGE_NAME"
  }
}
```

**NOTE:** `imageName` will return the name of the image found by Vuforia.

**Manually Closed** - when a user has exited Vuforia via pressing the close/back button, `data` returns: 

```json
{
  "status": {
    "manuallyClosed": true,
    "message": "User manually closed the plugin."
  }
}
```

##### `stopVuforia` - Stop your Vuforia session
From within your JavaScript file, add the following to stop the [Vuforia][vuforia] session.

**Why?** - Well, you could pair this with a setTimeout to give users a certain amount of time to search for an image.

```javascript
navigator.VuforiaPlugin.stopVuforia(function (data) {
    console.log(data);

    if (data.success == 'true') {
        alert('Stopped Vuforia');
    } else {
        alert('Couldn\'t stop Vuforia\n'+data.message);
    }
}, function (data) {
    console.log("Error: " + data);
});
```

This script could be paired with a timer, or other method to trigger the session close.

**NOTE:** You do not need to call `stopVuforia()` other than to force the session to end. If the user scans an image, or chooses to close the session themselves, the session will be automatically closed.


#### Using your own data
We know that eventually you're going to want to use your own data. To do so, follow these extra steps.

##### `www/targets/`
First, create a `targets/` folder inside `www/` and place your own `.xml` and `.dat` files inside.

**NOTE:** Adding a `.pdf` file isn't required, but might be helpful for testing and development purposes.

##### JavaScript
###### `startVuforia(...)`
There are two pieces you will need to replace:

1. `PluginTest.xml` - Replace with a reference to your custom data file e.g. `www/targets/CustomData.xml`
1. `[ 'logo', 'iceland', 'canterbury-grass', 'brick-lane' ]` - Replace with the specific images for your data file that you are searching for.

**NOTES:**
* You don't have to search for all of the images in your data file each time. Your data file may contain 20 images, but for this particular action you may be only interested in two.
* Data file paths can be either from the **resources folder** (which is the default) or **absolute** (in which case you'd start the `src` with `file://`). Absolute paths are useful if you'd like to access files in specific folders, like the iTunes sharing document folder for iOS, or the app root folder for Android.

##### `config.xml`
Add the following to your `config.xml` file:

```xml
<platform name="android">
    <resource-file src="www/targets/CustomData.xml" target="assets/CustomData.xml" />
    <resource-file src="www/targets/CustomData.dat" target="assets/CustomData.dat" />
</platform>

<platform name="ios">
    <resource-file src="targets/CustomData.xml" />
    <resource-file src="targets/CustomData.dat" />
</platform>
```

**NOTE:**
* File paths can be either from the **resources folder** (which is the default) or **absolute** (in which case you'd start the `src` with `file://`). Absolute paths are useful if you'd like to access files in specific folders, like the iTunes sharing document folder for iOS, or the app root folder for Android.


## Known Issues
### Fixed orientation - [issue #16][issue-16]
With the release of Cordova 6 and `cordova-ios` 4, orientation locking appears to be broken - [see this cordova issue][cordova-orientation-issue]. For now, if you wish to lock your orientation, please use `cordova-ios` 3.* and follow the instructions on the `cordova-ios-3` branch.


## Contributing
If you wish to submit a bug fix or feature, you can create a pull request and it will be merged pending a code review.

1. Clone it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## License
Cordova-Plugin-Vuforia is licensed under the [MIT License][info-license].

[logo]: https://cdn.rawgit.com/mattrayner/cordova-plugin-vuforia/d14d00720569fea02d29cded4de3c6e617c87537/images/logo.svg

[cordova]: https://cordova.apache.org/
[vuforia]: https://www.vuforia.com/
[example-repo]: https://github.com/dsgriffin/cordova-vuforia-example
[npm]: https://www.npmjs.com
[install-cordova]: https://cordova.apache.org/docs/en/latest/guide/cli/index.html#installing-the-cordova-cli
[updating-cordova]: https://cordova.apache.org/docs/en/latest/guide/cli/index.html#updating-cordova-and-your-project
[upgrading-ios]: https://cordova.apache.org/docs/en/latest/guide/platforms/ios/upgrade.html#upgrading-360-projects-to-400
[upgrading-android]: https://cordova.apache.org/docs/en/latest/guide/platforms/android/upgrade.html#upgrading-to-5xx
[issue-16]: https://github.com/mattrayner/cordova-plugin-vuforia/issues/16
[cordova-orientation-issue]: https://github.com/apache/cordova-lib/pull/260
[peugeot]: https://itunes.apple.com/gb/app/new-peugeot-208/id1020630968?mt=8

[info-npm]: https://www.npmjs.com/package/cordova-plugin-vuforia
[info-travis]: https://travis-ci.org/mattrayner/cordova-plugin-vuforia
[info-license]: LICENSE
[info-bithound]: https://www.bithound.io/github/mattrayner/cordova-plugin-vuforia
[shield-npm]: https://img.shields.io/npm/v/cordova-plugin-vuforia.svg
[shield-travis]: https://img.shields.io/travis/mattrayner/cordova-plugin-vuforia.svg
[shield-license]: https://img.shields.io/badge/license-MIT-blue.svg
[shield-bithound]: https://www.bithound.io/github/mattrayner/cordova-plugin-vuforia/badges/score.svg
[shield-cordova]: https://img.shields.io/badge/cordova%20support-6.*-blue.svg
