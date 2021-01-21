# HelloWhirly

This repository is meant to demonstrate a minimum viable WhirlyGlobe app.

The deviations from the existing tutorial are as follows:

- We use the `use_frameworks!` directive with Cocoapods since without it there appear to be issues with loading a default Metal library (see: https://github.com/mousebird/WhirlyGlobe/issues/1280)
