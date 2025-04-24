//
//  WaterfallGrid.swift
//  ADA-Challenge1
//
//  Created by Komang Wikananda on 20/04/25.
//

import SwiftUI

struct WaterfallGrid<Data, Content>: View where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View {
    let data: Data
    let columns: Int
    let content: (Data.Element) -> Content
    let spacing: CGFloat
    
    init(data: Data, columns: Int, spacing: CGFloat = 12, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.columns = columns
        self.content = content
        self.spacing = spacing
    }
    
    var body: some View {
//       ScrollView {
            // GeometryReader { geometry in
                let totalWidth = UIScreen.main.bounds.width
                let columnWidth = self.columnWidth(for: totalWidth)
                HStack(alignment: .top, spacing: spacing) {
                    ForEach(0..<columns, id: \.self) { columnIndex in
                        LazyVStack(spacing: 12) {
                            ForEach(columnItems(columnIndex)) { item in
                                content(item)
                            }
                        }
                        .frame(width: columnWidth)
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            // }
            // // This makes sure the grid grows vertically with its content
            // .frame(maxWidth: .infinity, alignment: .topLeading)            
//       }
    }
    
    private func columnWidth(for totalWidth: CGFloat) -> CGFloat {
        let horizontalPadding: CGFloat = 32
        let availableWidth = totalWidth - horizontalPadding - (CGFloat(columns - 1) * spacing)
        let width = max(100, availableWidth / CGFloat(columns))
        print("Total width: \(totalWidth), Available: \(availableWidth), Column width: \(width)")
        return width
    }
    
    private func columnItems(_ column: Int) -> [Data.Element] {
        var columnItems = [Data.Element]()
//        var columnIndices = Array(0..<columns)
        
        // create array for each column
        for (index, item) in data.enumerated() {
            if index % columns == column {
                columnItems.append(item)
            }
        }
        
        return columnItems
    }
 }
