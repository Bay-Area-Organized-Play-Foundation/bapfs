---
date: 2021-03-29 08:35
title: Basic Roll20 Macros
description: Learn how to get thinfgs done quick in roll20.
author: Doug Hahn
tags: Roll20, VTT
---
# Basic Roll20 Macros

To roll dice, you can use double brackets. For example, `[[1d20]]`.

You can pair this with simple language, to start making basic macros for things like saves. For example:

```
Fort: [[1d20+5]] (+1 vs poison effects)
```

### Multiple-line dice rolling

You can use multiple lines by prefacing your input with the `/me` command. So an attack macro might look like this:

```
/me
Longspear hits AC [[1d20+8]]
for [[1d8+4]] Piercing damage.
```

You can store this in a text document on your computer, and paste it into roll20. You don;t need fancy characer sheets.

### Saving Macros

1. In Roll20, click the Macros icon on the top right (the [3 lines](https://share.getcloudapp.com/OAuW5oYN)).
2. Click "Add" and a new window will appear. It looks like [this](https://share.getcloudapp.com/mXu1P76k).
3. Name the macro whatever you want. For example, a Will save macro might be called "Will."
4. Type in yur text. [Here is how it might look, using Will save as an example](https://share.getcloudapp.com/5zuA95YL).
5. Click "Test Macro." You should see the dice oll in the chat window.
6. Click "Save Changes."
7. Now you will see the [macro in the pane](https://share.getcloudapp.com/Jru1nwOZ) and you can use it any time by clicking the dice icon next to the name.

### Putting Macros in the Bar
1. In Roll20, click the Macros icon on the top right (the [3 lines](https://share.getcloudapp.com/OAuW5oYN)).
2. Click ["Show macro quick bar?"](https://share.getcloudapp.com/Qwu92QBY); this will activate the quick bar.
3. Click the "In Bar" option next to whatever macros you want to see. [Here is how that looks.](https://share.getcloudapp.com/6quQvD11)
4. You should now see the button on your screen. [A basic set looks like this](https://share.getcloudapp.com/ApuREOBr).

### Rolling Initiative & Adding it to the Tracker
You can rolll initiative at the click of a button and get it automatically added to the tracker. While this isn;t needed, it's a big time saver and helpful to the GM. Here is that basic macro:

```
/roll 1d20 + YOUR_MODIFIER &{tracker:+}
```

But initiative can change often depending on our Exploration Activity, and if someone is scouting. So we neeed to put that number in a place where we can modify that value easily.

#### Instructions

1. In Roll20, click the Macros icon on the top right (the [3 lines](https://share.getcloudapp.com/OAuW5oYN)).
2. Click "Add" and a new window will appear. It looks like [this](https://share.getcloudapp.com/mXu1P76k).
3. Name the macro at the top (just call it `Init`).
4. Add this macro: `/roll 1d20 + @{selected|bar2} &{tracker:+}`
5. It should look like [this](https://share.getcloudapp.com/d5uPogG8).
6. Click "Save Changes."
7. Click "In Bar" where the macro now appears. It looks [like this](https://share.getcloudapp.com/d5uPoDrw).
8. You should now see an "init" button under your name in roll20.
9. Click on your token. Add your modifier to the rightmost bubble. It looks [like this](https://share.getcloudapp.com/mXu5eGZ1).

Now, when when you click the `Init` button, it will roll initiative and add it to the tracker for you, using whatever you wrote in the bubble! If you need to change your exploration activity, just click on your token and change the bubble's value.

Note that you will need to edit the bubble on your default token, or add it every time you drag a new token onto a map.
