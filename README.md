# ColourViewer
Test of SwiftUI and Combine

### Main Screen
![Main Screen](Images/main.png "Main Screen")

The main screen is divided into two, the colour editor and the colour history list. The 3 sections of the editor are coupled together so that updating any value automatically updates the other two sections.

#### <img src="Images/square.and.pencil.png" height="23" width="25"> Editor Panel

The left hand panel is the editor. It has an RGB section, an HSB section and a colour section. Changing a value in the RGB section changes the HSB section as well and vice versa. Changes in either section also update the colour section. It in turn can be updated by the search panel or the history panel and in that case the RGB and HSB sections are also updated.

The colour section has 3 buttons:
* <img src="Images/rectangle.stack.badge.plus.png" height="18" width="20"> Add the current colour to the history list.
* <img src="Images/doc.on.clipboard.png" height="18" width="15"> Add the current colour to the clipboard.
* <img src="Images/magnifyingglass.png" height="18" width="20"> Open the search panel.

#### <img src="Images/rectangle.stack.png" height="23" width="25"> History Panel

### <img src="Images/magnifyingglass.png" height="23" width="25"> Colour Search Screen

![Colour Search Screen](Images/search.png "Colour Search Screen")

The Colour Search Screen allows searching for colours by CSS name. The list is automatically updated once two characters have been entered and tapping on the name closes the screen and copies the colour into the editor.
