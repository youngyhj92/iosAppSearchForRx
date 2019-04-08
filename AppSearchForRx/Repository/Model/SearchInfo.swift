//
//  SearchInfo.swift
//  AppSearchForRx
//
//  Created by hyunjun yang on 05/04/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import Foundation

struct SearchResponse :Codable {
    let resultCount : Int
    let results : [AppInformation]?
    
}

struct AppInformation : Codable {
    let isGameCenterEnabled : Bool
    let screenshotUrls : [URL]?
    let ipadScreenshotUrls : [URL]?
    let appletvScreenshotUrls : [URL]?
    let artistViewUrl : URL?
    let artworkUrl60 : URL?
    let artworkUrl512 : URL?
    let artworkUrl100 : URL?
    let supportedDevices : [String]?
    let kind : String?
    let features : [String]?
    let advisories : [String]?
    let averageUserRatingForCurrentVersion : Float?
    let trackCensoredName : String?
    let languageCodesISO2A : [String]?
    let fileSizeBytes : String?
    let sellerUrl : URL?
    let contentAdvisoryRating : String?
    let userRatingCountForCurrentVersion : Int?
    let trackViewUrl : URL?
    let trackContentRating : String?
    let isVppDeviceBasedLicensingEnabled : Bool
    let sellerName : String?
    let genreIds : [String]?
    let releaseNotes : String?
    let releaseDate : String?
    let primaryGenreName : String?
    let primaryGenreId : Int?
    let formattedPrice : String?
    let currency : String?
    let wrapperType : String?
    let version : String?
    let minimumOsVersion : String?
    let artistId : Int?
    let artistName : String?
    let genres : [String]?
    let price : Double?
    let description : String?
    let trackName : String?
    let bundleId : String?
    let trackId : Int?
    let currentVersionReleaseDate : String?
    
    init() {
        isGameCenterEnabled = false
        screenshotUrls = nil
        ipadScreenshotUrls = nil
        appletvScreenshotUrls = nil
        artistViewUrl = nil
        artworkUrl60 = nil
        artworkUrl512 = nil
        artworkUrl100 = nil
        supportedDevices = nil
        kind = nil
        features = nil
        advisories = nil
        averageUserRatingForCurrentVersion = nil
        trackCensoredName = nil
        languageCodesISO2A = nil
        fileSizeBytes = nil
        sellerUrl = nil
        contentAdvisoryRating = nil
        userRatingCountForCurrentVersion = nil
        trackViewUrl = nil
        trackContentRating = nil
        isVppDeviceBasedLicensingEnabled = false
        sellerName = nil
        genreIds = nil
        releaseNotes  = nil
        releaseDate = nil
        primaryGenreName = nil
        primaryGenreId = nil
        formattedPrice = nil
        currency = nil
        wrapperType = nil
        version = nil
        minimumOsVersion = nil
        artistId = nil
        artistName = nil
        genres = nil
        price = nil
        description = nil
        trackName = nil
        bundleId = nil
        trackId = nil
        currentVersionReleaseDate = nil
    }
}
