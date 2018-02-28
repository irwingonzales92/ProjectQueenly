//
//  Constants.swift
//  ProjectQueenly
//
//  Created by Irwin Gonzales on 11/17/17.
//  Copyright © 2017 Irwin Gonzales. All rights reserved.
//

import Foundation

// Location
let COORDINATE = "coordinate"

// Storyboard
let MAIN_STORYBOARD = "Main"


//USERS
let USER_IS_LEADER = "userIsLeader"
let USER_IS_GUEST = "userIsGuest"

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

//View Stuff
let VIEW_DRESS_POST = NSNotification.Name("viewDress")


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
