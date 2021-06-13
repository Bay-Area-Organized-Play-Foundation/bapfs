# BAPFS Readme

To compile css, cd into the bapfs directory of this project, and run this command in terminal after you've installed sass:
```
sass --watch Sources/Bapfs/Theme/smacss/styles.scss:Resources/styles.css --style compressed
```

To run locally on localhost:8000, cd into /bapfs/bapfs and run:
```
publish run
```

To make changes, build in xcode or your swift IDE of choice.

## Development

## Linux

Visit [https://swift.org/download/#releases] to find the swift release for your distro.

Update the path:

```sh
PATH="./swift-5.4-RELEASE-ubuntu20.04/usr/bin/:$PATH"

# Fish Shell
# set PATH "./swift-5.4-RELEASE-ubuntu20.04/usr/bin/:$PATH";

swift run publish-cli run
```
