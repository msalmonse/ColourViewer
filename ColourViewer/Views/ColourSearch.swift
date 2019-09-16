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
///  Global:
///     newLabel:          the recipient of the selected colour's name

struct ColourSearch: View {
    @ObservedObject var search = SearchString()
    @State var matchList: [ String ] = []
    @ObservedObject var lumaSort = ObservableBool(false)
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    /// Update the matching list of colour names
    private func updateMatchList(_ match: String) {
        if match.isEmpty {
            matchList.removeAll()
        } else {
            matchList = coloursMatching(match, sortByLuma: lumaSort.value)
        }
    }

    /// Update the ColourItem in the parent, clear the search data and close the sheet
    private func selectColour(_ name: String) {
        newLabel.value = name
        clearAll()
        dismiss()
    }

    // Dismiss the sheet
    private func dismiss() { mode.wrappedValue.dismiss() }

    // Clear the search data
    private func clearAll() {
        search.string = ""
        matchList = []
    }

    var body: some View {
        GeometryReader { gp in
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    .font(Font.title.weight(.bold))
                    .foregroundColor(.primary)
                    Spacer()
                    // Button to close the sheet
                    Button(
                        action: { self.dismiss() },
                        label: {
                            Image(systemName: "clear")
                            .font(Font.title.weight(.bold))
                            .foregroundColor(.primary)
                            .padding(.trailing, 10)
                        }
                    )
                }
                .padding(10)

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
                        .disableAutocorrection(true)
                        .autocapitalization(.none)

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
                    Toggle("Sort by luminosity:", isOn: self.$lumaSort.value)
                    .onReceive(self.lumaSort.publisher,
                            perform: { _ in self.updateMatchList(self.search.string) }
                    )
                    .frame(width: gp.relativeWidth(0.5), alignment: .center)
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
                .onReceive(self.search.publisher, perform: { self.updateMatchList($0) })
            }
        }
        .environment(\.horizontalSizeClass, .compact)
    }
}

#if DEBUG
struct ColourSearch_Previews: PreviewProvider {
    @ObservedObject static var showingSearch = ObservableBool(true)

    static var previews: some View {
        ColourSearch()
    }
}
#endif
