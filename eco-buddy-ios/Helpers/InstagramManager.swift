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
        guard let instagramURL = URL(string: "instagram://app") else {
            result?(false)
            return
        }

        guard UIApplication.shared.canOpenURL(instagramURL) else {
            self.presentAlert(title: "Instagram Not Installed", message: "Install Instagram to share this image.")
            result?(false)
            return
        }

        getLibraryPermissionIfNecessary { [weak self] hasPermission in
            guard let self else {
                result?(false)
                return
            }

            guard hasPermission else {
                self.presentAlert(title: "Photo Access Needed", message: "Allow photo library access to share this image on Instagram.")
                result?(false)
                return
            }

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    var assetID = ""
                    try PHPhotoLibrary.shared().performChangesAndWait {
                        let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
                        assetID = request.placeholderForCreatedAsset?.localIdentifier ?? ""
                    }

                    DispatchQueue.main.async {
                        guard let urlForRedirect = URL(string: "instagram://library?LocalIdentifier=\(assetID)") else {
                            result?(false)
                            return
                        }

                        UIApplication.shared.open(urlForRedirect) { success in
                            result?(success)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        result?(false)
                    }
                }
            }
        }
    }

    func getLibraryPermissionIfNecessary(completionHandler: @escaping  (Bool) -> Void) {
        let handleStatus: (PHAuthorizationStatus) -> Void = { status in
            switch status {
            case .authorized, .limited:
                completionHandler(true)
            default:
                completionHandler(false)
            }
        }

        if #available(iOS 14, *) {
            let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
            guard status == .notDetermined else {
                handleStatus(status)
                return
            }

            PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                DispatchQueue.main.async {
                    handleStatus(status)
                }
            }
        } else {
            let status = PHPhotoLibrary.authorizationStatus()
            guard status == .notDetermined else {
                handleStatus(status)
                return
            }

            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    handleStatus(status)
                }
            }
        }
    }

    private func presentAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.topViewController()?.present(alert, animated: true)
        }
    }

    private func topViewController(base: UIViewController? = nil) -> UIViewController? {
        let baseController = base ?? UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first(where: \.isKeyWindow)?
            .rootViewController

        if let navigationController = baseController as? UINavigationController {
            return topViewController(base: navigationController.visibleViewController)
        }

        if let tabBarController = baseController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return topViewController(base: selectedViewController)
        }

        if let presentedViewController = baseController?.presentedViewController {
            return topViewController(base: presentedViewController)
        }

        return baseController
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
