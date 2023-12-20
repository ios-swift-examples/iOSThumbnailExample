//
//  FileListItemView.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/18.
//

import SwiftUI

struct FileListItemView: View {
    @StateObject var viewModel: FileListItemViewModel
    @State var thumbnail: UIImage?
    
    var body: some View {
        VStack{
            Text(viewModel.name)
            if let thumbnail = thumbnail {
                Image.init(uiImage: thumbnail)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 100)
//                    .resizable()
//                    .frame(width: 100, height: 100)
            }
        }.onAppear{
            Task{
                await uppdateThumbnail()
            }
        }
        
    }
    
    func uppdateThumbnail() async {
        await viewModel.updateThumbnail()
        thumbnail = viewModel.thumbnail
    }
}

//#Preview {
////    @State var viewModel = FileListItemViewModel(file: File(url: Bundle.main.url(forResource: "sample", withExtension: "png")!))
////    Text("")
//    
//    FileListItemView(viewModel:.constant(FileListItemViewModel(file: File(url: Bundle.main.url(forResource: "sample", withExtension: "png")!))))
//}
