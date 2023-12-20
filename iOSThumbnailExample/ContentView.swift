//
//  ContentView.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Thumbnails")
        VStack {
            FileListView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
