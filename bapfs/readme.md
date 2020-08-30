# BAPFS Readme

## Dependencies
This project has a sass dependency.
https://github.com/Hejki/SassPublishPlugin

To compile css, cd into the root directory of this project, and run this command in terminal:
```
sass --watch Sources/Bapfs/Theme/smacss/styles.scss:Resources/styles.css --style compressed
```

We probably want to gitignore the Output folder and build whenever someone pushes; not sure how you have your setup done here, Joe. Leaving it for now. 
