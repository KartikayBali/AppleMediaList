//
//  UserDataManager.swift
//  AppleMediaList
//
//  Created by Bali on 19/10/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

enum MediaType: String {
  case AppleMusic = "Apple Music"
  case iTunesMusic = "iTunes Music"
  case iOSApps = "iOS Apps"
  case Audiobooks = "Audiobooks"
  case Books = "Books"
  case TVShows = "TV Shows"
  case Movies = "Movies"
  case iTunesU = "iTunes U"
  case Podcasts = "Podcasts"
  case MusicVideos = "Music Videos"
  
  static let AllMediaTypes = [AppleMusic, iTunesMusic, iOSApps, Audiobooks, Books, TVShows, Movies, iTunesU, Podcasts, MusicVideos]
}

enum FeedType: String {
  case ComingSoon = "Coming Soon"
  case HotTracks = "Hot Tracks"
  case NewReleases = "New Releases"
  case NewMusic = "New Music"
  case TopAlbums = "Top Albums"
  case TopSongs = "Top Songs"
  case RecentReleases = "Recent Releases"
  case NewAppsWeLove = "New Apps We Love"
  case NewGamesWeLove = "New Games We Love"
  case TopFree = "Top Free"
  case TopFreeiPad = "Top Free iPad"
  case TopGrossing = "Top Grossing"
  case TopGrossingiPad = "Top Grossing iPad"
  case TopPaid = "Top Paid"
  case TopAudiobooks = "Top Audiobooks"
  case TopTVEpisodes = "Top TV Episodes"
  case TopTVSeasons = "Top TV Seasons"
  case TopMovies = "Top Movies"
  case TopiTunesUCourses = "Top iTunes U Courses"
  case TopPodcasts = "Top Podcasts"
  case TopMusicVideos = "Top Music Videos"
  
  static let FeedTypeInfo: [MediaType: [FeedType]] = [
    MediaType.AppleMusic: [ComingSoon, HotTracks, NewReleases, TopAlbums, TopSongs],
    MediaType.iTunesMusic: [HotTracks, NewMusic, RecentReleases, TopAlbums, TopSongs],
    MediaType.iOSApps: [NewAppsWeLove, NewGamesWeLove, TopFree, TopFreeiPad, TopGrossing, TopGrossingiPad, TopPaid],
    MediaType.Audiobooks: [TopAudiobooks],
    MediaType.Books: [TopFree, TopPaid],
    MediaType.TVShows: [TopTVEpisodes, TopTVSeasons],
    MediaType.Movies: [TopMovies],
    MediaType.iTunesU: [TopiTunesUCourses],
    MediaType.Podcasts: [TopPodcasts],
    MediaType.MusicVideos: [TopMusicVideos]
  ]
}

class UserDataManager {
  static let shared = UserDataManager()
  
  var mediaType = MediaType.AllMediaTypes[0]
  var feedType = FeedType.FeedTypeInfo[MediaType.AllMediaTypes[0]]![0]
  let genre = "all"
  var resultLimit = 10
  var allowExplicit = true
  
  var explicitText: String {
    return allowExplicit ? "explicit" : "non-explicit"
  }
    
}
