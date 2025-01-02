//
//  businessModuleModel.swift
//  EstimatorPDF
//
//  Created by Jessica VanDusen on 2025-01-03.
//

import Foundation
import UIKit

struct BusinessModel {
    
    let businessID: UUID
    let businessName: String
    let businessAddress: String?
    
    let businessPhone: String?
    let businessEmail: String?
    let businessWebsite: String?
    
    let businessDescription: String
    let businessServices: String?
    
    let businessImageName: String // Name of the image in assets
    let businessLogoName: String // Name of the logo in assets
        
    var businessImage: UIImage? {
        UIImage(named: businessImageName)
    }
        
    var businessLogo: UIImage? {
        UIImage(named: businessLogoName)
    }
    
}

//TODO: build a UIImage checker, for PNG/JPEG images, future proof with gif, and 3d images, maybe even photoslides(so it changes over a period of time)
//TODO: Business Address includes an array of information not just a string

//TODO: Phone number needs to be set in proper foramate for location

