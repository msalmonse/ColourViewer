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
    @State var intensitySort = false
    @ObservedObject var sortSelection = ObservableInt(0)
    
    /// Update the matching list of colour names
    private func updateMatchList(_ match: String) {
        matchList = coloursMatching(match, sortByIntensity: intensitySort)
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
        NavigationView {
            VStack {
                VStack {
                    /// Input field for the search
                    HStack {
                        /// Force a search, only active if the search string isn't empty
                        Button(
                            action: { self.updateMatchList(self.search.string) },
                            label: {
                                Image(systemName: "magnifyingglass")
                                .foregroundColor(search.isEmpty ? .secondary : .primary)
                                .padding(.leading, 10)
                            }
                        )
                        .disabled(search.isEmpty)

                        /// The actual search string editor, see also .onReceive() below
                        TextField("Seach", text: $search.string,
                            onCommit: { self.updateMatchList(self.search.string) }
                        )

                        /// Clear the search data
                        Button(
                            action: { self.clearAll() },
                            label: {
                                Image(systemName: "clear")
                                .foregroundColor(
                                    (search.isEmpty && matchList.isEmpty) ? .secondary : .primary
                                )
                                .padding(.trailing, 10)
                            }
                        )
                    }
                    .padding(3)
                    .overlay(strokedRoundedRectangle(cornerRadius: 3))

                    /// Select the sort field
                    HStack {
                        Text("Sorted by:")
                        Picker("Sorted by", selection: $sortSelection.number) {
                            Text("Name").tag(0)
                            Text("Intensity").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 200)
                        /// When a new sort style is selected update the match list
                        .onReceive(sortSelection.publisher) {
                            self.intensitySort = ($0 == 1)
                            self.updateMatchList(self.search.string)
                        }
                    }
                    .font(.caption)
                }
                .padding(.horizontal, 5)
                
                Text("Tap on colour to select").font(.caption)

                /// Display the names and colours of the matching colours
                List(matchList, id: \.self) { match in
                    /// Each entry in the list is a button to update the colour in the parent and close the sheet
                    Button(
                        action: { self.selectColour(match) },
                        label: {
                            Text(match)
                            .font(.subheadline)
                            .padding(.horizontal, 2)
                            .padding(.vertical, 8)
                            .frame(width: 160, alignment: .leading)
                            .foregroundColor(.black)
                            .background(filledRoundedRectangle(cornerRadius: 2, color: .white))
                            .frame(width: 325, alignment: .leading)
                            .overlay(strokedRoundedRectangle(cornerRadius: 3))
                            .background(filledRoundedRectangle(cornerRadius: 3, color: colorLookup(match)!))

                        }
                    )
                }
                /// When the search string is updated the match list is recalculated
                .onReceive(search.publisher, perform: { self.updateMatchList($0) } )
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

#if DEBUG
struct ColourSearch_Previews: PreviewProvider {
    //@State static var showingSearch = true
    @ObservedObject static var showingSearch = ObservableBool(true)
    @ObservedObject static var colourItem = ObservableColourItem(label: "RebeccaPurple")

    static var previews: some View {
        ColourSearch(showingSearch: showingSearch, colourItem: colourItem)
    }
}
#endif
