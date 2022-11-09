//
//  RequestManager.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import Alamofire

//MARK: Error key
enum RMErrorKey: String {
    case url = "Error_url"
    case request = "Error_request"
    case parsing = "Error_parsing"
    case general = "Error_general"
}

//MARK: Properties
class RequestManager: NSObject {
    
    public static let shared = RequestManager()
}

//MARK: Top rated movie list
extension RequestManager {
    
    static func getTopRatedMovieList(from page: Int,
                                     _ completion: @escaping((TopRatedMovieDetails?, String?) -> ())) {
        let path = String(format: AppConstants.Api.top_rated_movie,
                         AppConstants.Api.base_url,
                         AppConstants.Api.api_key,
                         AppConstants.Api.language,
                         page)
        
        debugPrint("API:- \(path)")
        debugPrint("RESPONSE_MODEL:- \(TopRatedMovieDetails.self)")
        
        guard let url = URL(string: path) else {
            completion(nil, RMErrorKey.url.rawValue)
            return
        }
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.prettyPrinted).response { response in
            if let data = response.data {
                guard let result = try? JSONDecoder().decode(TopRatedMovieDetails.self, from: data) else {
                    completion(nil, RMErrorKey.parsing.rawValue)
                    return
                }
                debugPrint("RESPONSE:-")
                debugPrint(result.asDictionary() ?? [:])
                completion(result, nil)
            } else {
                completion(nil, RMErrorKey.request.rawValue)
                return
            }
        }
    }
}

//MARK: Movie details
extension RequestManager {
    
    static func getMovieDetails(with id: Int?,
                             _ completion: @escaping((MovieDetails?, String?) -> ())) {
        guard let id = id else {
            completion(nil, RMErrorKey.general.rawValue)
            return
        }
        let path = String(format: AppConstants.Api.movie_details,
                          AppConstants.Api.base_url,
                          id,
                          AppConstants.Api.api_key,
                          AppConstants.Api.language)
        
        debugPrint("API:- \(path)")
        debugPrint("RESPONSE_MODEL:- \(MovieDetails.self)")
        
        guard let url = URL(string: path) else {
            completion(nil, RMErrorKey.url.rawValue)
            return
        }
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.prettyPrinted).response { response in
            if let data = response.data {
                guard let result = try? JSONDecoder().decode(MovieDetails.self, from: data) else {
                    completion(nil, RMErrorKey.parsing.rawValue)
                    return
                }
                debugPrint("RESPONSE:-")
                debugPrint(result.asDictionary() ?? [:])
                completion(result, nil)
            } else {
                completion(nil, RMErrorKey.request.rawValue)
                return
            }
        }
    }
}

