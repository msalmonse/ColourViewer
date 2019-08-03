//
//  ColourSearch.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-22.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import Combine

/// Search the colour list and display matching name along with their colour
///
/// Parameters:
///     showingSearch: the Bool that determines if this sheet is shown
///     colourItem:         the recipient of the selected colour

struct ColourSearch: View {
    @ObservedObject var showingSearch: ObservableBool
    @ObservedObject var colourItem: ObservableColourItem
    @ObservedObject var search = SearchString()
    @State var matchList: [ String ] = []
    @ObservedObject var intensitySort = ObservableBool(false)
    
    /// Update the matching list of colour names
    private func updateMatchList(_ match: String) {
        matchList = coloursMatching(match, sortByIntensity: intensitySort.bool)
    }
    
    /// Update the ColourItem in the parent, clear the search data and close the sheet
    private func selectColour(_ name: String) {
        colourItem.label = name
        clearAll()
        showingSearch.bool = false
    }
    
    /// Clear the search data
    private func clearAll() {
        search.string = ""
        matchList = []
    }
        
    var body: some View {
        GeometryReader { gp in
            NavigationView {
                VStack {
                    VStack {
                        // Input field for the search
                        HStack {
                            // Force a search, only active if the search string isn't empty
                            Button(
                                action: { self.updateMatchList(self.search.string) },
                                label: {
                                    Image(systemName: "magnifyingglass")
                                    .foregroundColor(self.search.isEmpty ? .secondary : .primary)
                                    .padding(.leading, 10)
                                }
                            )
                            .disabled(self.search.isEmpty)

                            // The actual search string editor, see also .onReceive() below
                            TextField("Seach", text: self.$search.string,
                                onCommit: { self.updateMatchList(self.search.string) }
                            )

                            // Clear the search data
                            Button(
                                action: { self.clearAll() },
                                label: {
                                    Image(systemName: "clear")
                                    .foregroundColor(
                                        (self.search.isEmpty && self.matchList.isEmpty) ? .secondary : .primary
                                    )
                                    .padding(.trailing, 10)
                                }
                            )
                        }
                        .padding(3)
                        .overlay(strokedRoundedRectangle(cornerRadius: 3))

                        // Select the sort field
                        Toggle("Sort by intensity:", isOn: self.$intensitySort.bool)
                        .onReceive(self.intensitySort.publisher,
                                perform: { _ in self.updateMatchList(self.search.string) }
                        )
                        .frame(width: gp.relativeWidth(0.4), alignment: .center)
                        .font(.callout)
                    }
                    .padding(.horizontal, 5)
                    
                    Text("Tap on colour to select").font(.caption)

                    // Display the names and colours of the matching colours
                    List(self.matchList, id: \.self) { match in
                        // Each entry in the list is a button that updates the colour in the parent and closes the sheet
                        Button(
                            action: { self.selectColour(match) },
                            label: {
                                Text(match)
                                    .lineLimit(1)
                                    .font(.subheadline)
                                    .padding(3)
                                    .frame(width: gp.relativeWidth(0.3), alignment: .leading)
                                    .foregroundColor(.black)
                                    .background(filledRoundedRectangle(cornerRadius: 2,
                                                                color: .white))
                                    .frame(width: gp.relativeWidth(0.95) - 10, alignment: .leading)
                                    .overlay(strokedRoundedRectangle(cornerRadius: 3))
                                    .background(filledRoundedRectangle(cornerRadius: 3,
                                                                color: colorLookup(match)!)
                                )
                            }
                        )
                    }
                    // When the search string is updated the match list is recalculated
                    .onReceive(self.search.publisher, perform: {
                            self.updateMatchList($0)
                        }
                    )
                }
                .navigationBarItems(
                    leading: Image(systemName: "magnifyingglass").font(Font.title.weight(.bold)),
                    /// Button to close the sheet
                    trailing: Button(
                        action: { self.showingSearch.bool = false },
                        label: {
                            Image(systemName: "clear")
                            .font(Font.title.weight(.bold))
                            .accentColor(.primary)
                        }
                    )
                    .accessibility(hint: Text("Cancel"))
                )
            }
        }
    }
}

#if DEBUG
struct ColourSearch_Previews: PreviewProvider {
    //@State static var showingSearch = true
    @ObservedObject static var showingSearch = ObservableBool(true)
    @ObservedObject static var colourItem = ObservableColourItem(label: "RebeccaPurple")

    static var previews: some View {
        ColourSearch(
            showingSearch: showingSearch,
            colourItem: colourItem
        )
    }
}
#endif
