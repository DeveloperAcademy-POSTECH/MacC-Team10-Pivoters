//
//  ImageMetadataProvider.swift
//  Feature
//
//  Created by Ha Jong Myeong on 11/9/23.
//  Copyright © 2023 com.pivoters. All rights reserved.
//

import Foundation
import UIKit
import LinkPresentation
import Core

public class ImageMetadataProvider: UIActivityItemProvider {
    var image: UIImage
    var team: TeamV1
    var lineup: LineupV1

    init(image: UIImage, team: TeamV1, lineup: LineupV1) {
        self.image = image
        self.team = team
        self.lineup = lineup
        super.init(placeholderItem: image)
    }

    public override var item: Any {
        return self.image
    }

    @available(iOS 13.0, *)
    public override func activityViewControllerLinkMetadata(
        _ activityViewController: UIActivityViewController
    ) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = team.teamName
        metadata.originalURL = URL(fileURLWithPath: lineup.lineupName)
        var thumbnail: NSSecureCoding = NSNull()
        if let imageData = self.image.pngData() {
            thumbnail = NSData(data: imageData)
        }

        metadata.imageProvider = NSItemProvider(item: thumbnail, typeIdentifier: "public.png")

        return metadata
    }
}
