//
//  AppConstants.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import Foundation

class AppConstants {
    
    struct Api {
        static let api_key = "c37d3b40004717511adb2c1fbb15eda4"
        static let base_url = "https://api.themoviedb.org/3/"
        static let image_cdn = "https://image.tmdb.org/t/p/original/"
        
        static let language = "en-US"
        
        static let top_rated_movie = "%@movie/top_rated?api_key=%@&language=%@&page=%d"
        //<base_url>movie/top_rated?api_key=<api_key>&language=en-US&page=<page_number>
        
        static let movie_details = "%@movie/%d?api_key=%@&language=%@"
        //<base_url>movie/<movie_id>?api_key=<api_key>&language=en-US
        
        static let image_path = "%@%@"
        //https://image.tmdb.org/t/p/original/<image_path>
    }
}
