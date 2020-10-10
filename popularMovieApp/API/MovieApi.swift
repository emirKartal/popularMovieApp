//
//  MovieAPI.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case getPopularMovies(page: Int)
    case getMovieDetail(id: Int)
    case getCredits(id: Int)
}

extension MovieApi: TargetType {
    var baseURL: URL { return URL(string: "https://api.themoviedb.org")! }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "3/movie/popular"
        case .getMovieDetail(let id):
            return "3/movie/\(id)"
        case .getCredits(let id):
            return "3/movie/\(id)/credits"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPopularMovies, .getMovieDetail, .getCredits:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getPopularMovies:
            do{
                guard let url = Bundle.main.url(forResource: "MovieListMock", withExtension: "json") else { return Data() }
                let data = try Data(contentsOf: url)
                return data
            }catch{
                print(error)
                return Data()
            }
        default:
            return Data()
        }
        
    }
    
    var task: Task {
        switch self {
        case .getPopularMovies(let page):
            let parameters: [String: Any] = ["api_key": API_KEY, "page": page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getMovieDetail, .getCredits:
            let parameters: [String: Any] = ["api_key": API_KEY]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json",
        "Content-Type": "application/json"]
    }
}
