//
//  TopRatedMovieDetails.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import UIKit

class TopRatedMovieDetails: Codable {
    
    let page: Int?
    let results: [ResultDetails]?
    let totalPages: Int?
    let totalResults: Int?
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case success
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        page = try? values?.decodeIfPresent(Int.self, forKey: .page)
        results = try? values?.decodeIfPresent([ResultDetails].self, forKey: .results)
        totalPages = try? values?.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try? values?.decodeIfPresent(Int.self, forKey: .totalResults)
        success = try? values?.decodeIfPresent(Bool.self, forKey: .success)
    }
}

class ResultDetails: Codable {
    
    let id: Int?
    let title: String?
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int.self, forKey: .id)
        title = try? values?.decodeIfPresent(String.self, forKey: .title)
        posterPath = try? values?.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try? values?.decodeIfPresent(String.self, forKey: .releaseDate)
    }
    
    func getThumbnailUrl() -> URL? {
        guard let imagePath = self.posterPath else {
            return nil
        }
        let path = String(format: AppConstants.Api.image_path,
                          AppConstants.Api.image_cdn,
                          imagePath)
        return URL(string: path)
    }
    
    func getYearFromReleaseDate() -> String? {
        if let releaseDate = self.releaseDate {
            let input = releaseDate
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: input) {
                formatter.dateFormat = "yyyy"
                let year = formatter.string(from: date)
                return "\(year)"
            }
        }
        return nil
    }
}
