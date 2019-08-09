# ColourViewer
Test of SwiftUI and Combine

### Main Screen
![Main Portrait Screen](Images/portrait.png "Main Portrait Screen")
![Main Landscape Screen](Images/landscape.png "Main Landscape Screen")

The main screen is divided into two, the colour editor and the colour history list. The 3 sections of the editor are coupled together so that updating any value automatically updates the other two sections.

#### <img src="Images/square.and.pencil.png" height="23" width="25"> Editor Panel

The left hand panel is the editor. It has an RGB section, an HSB section and a colour section. Changing a value in the RGB section changes the HSB section as well and vice versa. Changes in either section also update the colour section. It in turn can be updated by the search panel or the history panel and in that case the RGB and HSB sections are also updated.

The colour section displays the colour and it's well known name if one exists. If it doesn't then the hexadecimal code is displayed

The colour section has 3 buttons:
* <img src="Images/rectangle.stack.badge.plus.png" height="18" width="20"> Add the current colour to the history list.
* <img src="Images/doc.on.clipboard.png" height="18" width="15"> Add the current colour to the clipboard.
* <img src="Images/magnifyingglass.png" height="18" width="20"> Open the search panel.

#### <img src="Images/rectangle.stack.png" height="23" width="25"> History Panel

The history panel displays colours added to it using the <img src="Images/rectangle.stack.badge.plus.png" height="18" width="20"> button. The list items can be moved or deleted if the Edit button at the top right is tapped.

Each item is itself a button and tapping it will update the editor.

### <img src="Images/magnifyingglass.png" height="23" width="25"> Colour Search Screen

![Colour Search Screen](Images/search.png "Colour Search Screen")

The Colour Search Screen allows searching for colours by CSS name. The list is automatically updated once two characters have been entered and tapping on the name closes the screen and copies the colour into the editor.

The large <img src="Images/clear.png" height="15" width="18"> button in the top right hand corner close the screen without doing anything.

The screen starts searching as soon as two characters have been entered into the textfield but a single character may be searched for by pressing enter or the little <img src="Images/magnifyingglass.png" height="15" width="18"> button to the left of the text. The <img src="Images/clear.png" height="15" width="18"> button clears both the text field and the matched colours list.

The colours whose name conains the text in the search field are displayed below the text. The list is normally sorted by name but can be sorted by luminosity (ITU-R Rec. BT-709) which is a measure of the colours luminosity. Tapping on any name closes the sheet and copies that name into the editor.
