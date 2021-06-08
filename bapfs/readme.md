# BAPFS Readme

To compile css, cd into the bapfs directory of this project, and run this command in terminal after you've installes sass:
```
sass --watch Sources/Bapfs/Theme/smacss/styles.scss:Resources/styles.css --style compressed
```

To run locally on localhost:8000, cd into /bapfs/bapfs and run:
```
publish run
```

To  ake changes, build in xcode or your swift IDE of choice.

We probably want to gitignore the Output folder and build and deploy whenever someone pushes; not sure how you have your setup here, Joe. Leaving it for now.
