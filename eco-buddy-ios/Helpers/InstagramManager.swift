//
//  InstagramManager.swift
//  eco-buddy-ios
//
//  Created by Rohit Mahesh on 13/10/23.
//

import UIKit
import SwiftUI
import LinkPresentation
import Photos

final class InstagramManager : NSObject {
    
    public static let instance = InstagramManager()
    
    func postImage(image: UIImage, result:((Bool)->Void)? = nil) {
        guard let instagramURL = NSURL(string: "instagram://app") else {
            if let result = result {
                result(false)
            }
            return
        }
        
        // let image = image.scaleImageWithAspectToWidth(640)
        
        do {
            try PHPhotoLibrary.shared().performChangesAndWait {
                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                
                let assetID = request.placeholderForCreatedAsset?.localIdentifier ?? ""
                let shareURL = "instagram://library?LocalIdentifier=" + assetID
                
                if UIApplication.shared.canOpenURL(instagramURL as URL) {
                    if let urlForRedirect = NSURL(string: shareURL) {
                        UIApplication.shared.open(URL(string: "\(urlForRedirect)")!)
                    }
                } else {
                    let alert = UIAlertController(title: "Instagram Not Installed", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                        viewController.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } catch {
            if let result = result {
                result(false)
            }
        }
    }

    func getLibraryPermissionIfNecessary(completionHandler: @escaping  (Bool) -> Void) {
        
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized)
        }
    }
}

extension UIImage {
    // MARK: - UIImage+Resize
    
    func scaleImageWithAspectToWidth(_ toWidth:CGFloat) -> UIImage {
        let oldWidth:CGFloat = size.width
        let scaleFactor:CGFloat = toWidth / oldWidth
        
        let newHeight = self.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor;
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


struct ShareSheet: UIViewControllerRepresentable {
    let photo: UIImage
    let text: String
    func makeUIViewController(context: Context) -> UIActivityViewController {

        let activityItems: [Any] = [photo, text]
        
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
      
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

class ShareActivityItemSource: NSObject, UIActivityItemSource {
    
    var shareText: String
    var shareImage: UIImage
    var linkMetaData = LPLinkMetadata()
    
    init(shareText: String, shareImage: UIImage) {
        self.shareText = shareText
        self.shareImage = shareImage
        linkMetaData.title = shareText
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage(named: "AppIcon") as Any
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
        return shareImage
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetaData
    }
}
