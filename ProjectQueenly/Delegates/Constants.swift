//
//  Constants.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 11/17/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation


// Storyboard
let MAIN_STORYBOARD = "Main"


// USER ACTION SEGUE IDs
let USER_POSTING_ISO =  NSNotification.Name("POSTING_ISO")
let USER_CONFIRMING_POST = NSNotification.Name("CONFIRMING_POST")
let USER_VIEWING_OFFER = NSNotification.Name("VIEWING_OFFER")
let USER_MAKING_OFFER = NSNotification.Name("MAKING_OFFER")
let USER_ACCEPTING_OFFER = NSNotification.Name("ACCEPTING_OFFER")
let USER_VIEWING_POST = NSNotification.Name("VIEWING_POST")


//USER STATE
let USER_IS_LOGGED_IN = Notification.Name.init(rawValue: "UserLoggedIn")

// ViewControllers
let VC_LEFT_PANEL = "LeftSidePanelVC"
let VC_HOME = "HomeVC"
let VC_LOGIN = "LoginVC"

//Post Dress (ISO/SALE)
let ISO_POST = NSNotification.Name("userPostedDressForIso")
let WARDROBE_POST = NSNotification.Name("userPostedDressForWardrobe")
let WARDROBE_OFFER = Notification.Name("WardrobeOffered")


// Cell Identifiers
let CELL_DISPLAYNAME_ID = "userDisplayNameCell"
let CELL_PRICE_ID = "gownPriceCell"
let CELL_COLOR_ID = "gownColorCell"
let CELL_DESCRIPTION_ID = "gownDescriptionCell"
let CELL_MEASUREMENT_ID =  "gownMeasurementCell"


// FROM WHERE
let FROM_PROFILE_VC = NSNotification.Name("fromProfileVC")
let FROM_ROOT_VC = NSNotification.Name("fromRootVC")
let FROM_POST_DETAIL_VC = Notification.Name("FromPostDetailVC")
let FROM_ISOOFFER_VC = Notification.Name("FromIsoOffer")


// Error Messages
let ERROR_MSG_NO_MATCHES_FOUND = "No matches found. Please try again!"
let ERROR_MSG_INVALID_EMAIL = "Sorry, the email you've entered appears to be invalid. Please try another email."
let ERROR_MSG_EMAIL_ALREADY_IN_USE = "It appears that email is already in use by another user. Please try again."
let ERROR_MSG_WRONG_PASSWORD = "The password you tried is incorrect. Please try again."
let ERROR_MSG_UNEXPECTED_ERROR = "There has been an unexpected error. Please try again."
