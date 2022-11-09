//
//  MovieDetails.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 8/11/22.
//

import UIKit

class MovieDetails: Codable {
    
    let backdropPath: String?
    let posterPath: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let runtime: Int?
    let genres: [GenreDetails]?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case runtime
        case genres
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try? values?.decodeIfPresent(String.self, forKey: .backdropPath)
        posterPath = try? values?.decodeIfPresent(String.self, forKey: .posterPath)
        originalTitle = try? values?.decodeIfPresent(String.self, forKey: .originalTitle)
        overview = try? values?.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try? values?.decodeIfPresent(String.self, forKey: .releaseDate)
        runtime = try? values?.decodeIfPresent(Int.self, forKey: .runtime)
        genres = try? values?.decodeIfPresent([GenreDetails].self, forKey: .genres)
    }
    
    func getBackdropUrl() -> URL? {
        guard let imagePath = self.backdropPath else {
            return nil
        }
        let path = String(format: AppConstants.Api.image_path,
                          AppConstants.Api.image_cdn,
                          imagePath)
        return URL(string: path)
    }
    
    func getposterUrl() -> URL? {
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
    
    func getTimeFormatFromRunTime() -> String? {
        if let runtime = self.runtime {
            return String(format: "%dh %dm", (runtime / 60), (runtime % 60))
        }
        return nil
    }
}

class GenreDetails: Codable {
    
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? values?.decodeIfPresent(Int.self, forKey: .id)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
    }
}
