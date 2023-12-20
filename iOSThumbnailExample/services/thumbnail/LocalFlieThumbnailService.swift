//
//  LocalFlieThumbnailService.swift
//  iOSThumbnailExample
//
//  Created by 영준 이 on 2023/12/19.
//

import Foundation
import UIKit
import AVFoundation

class LocalFileThumbnailService: ThumbnailService {
    enum FileExtension: String{
        case MP3 = "mp3"
        case MP4 = "mp4"
        case M4V = "m4v"
        case MOV = "mov"
        case PDF = "pdf"
    }
    
    static var shared = LocalFileThumbnailService()
    
    func getThumbnail(_ url: URL) async -> UIImage? {
        guard url.isFileURL else {
            assertionFailure("it is not local file]")
            return nil
        }
        
        do {
            guard let ext = FileExtension.init(rawValue: url.pathExtension.lowercased()) else{
                return try getImageThumbnail(url)
            }
            
            switch ext {
                case .MP3:
                    return try await getAudioThumbnail(url)
                case .MP4, .M4V, .MOV:
                    return try getVideoThumbnail(url)
                case .PDF:
                    return try getPDFThumbnail(url)
            }
        } catch let error {
            assertionFailure("Thumbnail Generating failed. Error[\(error.localizedDescription)]")
        }
        
        return nil
    }
    
    func getImageThumbnail(_ url: URL) throws -> UIImage? {
        return UIImage.init(data: try! .init(contentsOf: url))
    }
    
    func getAudioThumbnail(_ url: URL) async throws -> UIImage? {
        let playerItem = AVPlayerItem(url: url);
        let metas = try await playerItem.asset.loadMetadata(for: .id3Metadata);
        let artworkMeta = metas.first{ $0.commonKey == .commonKeyArtwork }
        if let imageData = try await artworkMeta?.load(.dataValue) {
            return UIImage(data: imageData);
        }
        
        return nil
    }
    
    func getVideoThumbnail(_ url: URL) throws -> UIImage? {
        let asset = AVURLAsset(url: url);
        do{
            let imageGen = AVAssetImageGenerator(asset: asset);
            let cgImage = try imageGen.copyCGImage(at: .zero, actualTime: nil);
            return UIImage(cgImage: cgImage);
        }catch{
        }
        
        return nil
    }
    
    func getPDFThumbnail(_ url: URL) throws -> UIImage? {
        guard let doc : CGPDFDocument = .init(url as CFURL) else {
            return nil
        }
        
        guard let page = doc.page(at: 1) else{
            return nil
        }
        
        let frame = page.getBoxRect(.cropBox)
        let size  = frame.size
        
        let renderer = UIGraphicsImageRenderer(size: size)
        guard let image = renderer.image(actions: { context in
            let ctx = context.cgContext
            
            ctx.drawPDFPage(page)
        }).cgImage else {
            return nil
        }
        
        return UIImage(cgImage: image, scale: 1, orientation: .downMirrored)
    }
}
