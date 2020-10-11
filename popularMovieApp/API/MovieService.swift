//
//  MovieService.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import Moya

class MovieService: ServiceProtocol {
    var provider: MoyaProvider<MovieApi>!
    
    required init(isMock: Bool) {
        if isMock {
            provider = MoyaProvider<MovieApi>(stubClosure: MoyaProvider.immediatelyStub, plugins: self.moyaPlugins())
        } else {
            provider = MoyaProvider<MovieApi>(stubClosure: MoyaProvider.neverStub, plugins: self.moyaPlugins())
        }
    }
    
    func getPopularMovies(page: Int, completion: @escaping(Result<BaseModel<[MovieModel]>, APIError>)-> ()) {
        self.provider.request(.getPopularMovies(page: page)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let responseModel = try Decoders.mainDecoder.decode(BaseModel<[MovieModel]>.self, from: response.data)
                    completion(.success(responseModel))
                }catch {
                    print(error)
                    completion(.failure(.parseError))
                }
                break
            case .failure(let error):
                let errorMessage = self.getResponseError(from: error)
                completion(.failure(errorMessage))
                break
            }
            
        }
    }
    
    func getMovieDetail(id: Int, completion: @escaping(Result<MovieDetailModel, APIError>)-> ()) {
        self.provider.request(.getMovieDetail(id: id)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let movieDetailModel = try Decoders.mainDecoder.decode(MovieDetailModel.self, from: response.data)
                    completion(.success(movieDetailModel))
                }catch {
                    print(error)
                    completion(.failure(.parseError))
                }
                break
            case .failure(let error):
                let errorMessage = self.getResponseError(from: error)
                completion(.failure(errorMessage))
                break
            }
        }
    }
    
    func getCast(id: Int, completion: @escaping(Result<[CastModel], APIError>)-> ()) {
        self.provider.request(.getCredits(id: id)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let credits = try Decoders.mainDecoder.decode(CreditModel.self, from: response.data)
                    let castList = credits.cast ?? []
                    completion(.success(castList))
                }catch {
                    print(error)
                    completion(.failure(.parseError))
                }
                break
            case .failure(let error):
                let errorMessage = self.getResponseError(from: error)
                completion(.failure(errorMessage))
                break
            }
        }
    }
    
    func getMultiSearchResults(text: String, completion: @escaping(Result<SearchModel, APIError>)-> ()) {
        self.provider.request(.multiSearch(text: text)) { (result) in
            switch result {
            case .success(let response):
                do{
                    var movies: [MovieModel] = []
                    var persons: [PersonModel] = []
                    let responseModel = try Decoders.mainDecoder.decode(BaseModel<[RawSearchModel]>.self, from: response.data)
                    let searchListArray = responseModel.results
                    searchListArray?.forEach({ (searchModel) in
                        if searchModel.mediaType == "person" {
                            let person = PersonModel(id: searchModel.id, name: searchModel.name, profilePath: IMAGE_URL + (searchModel.profilePath ?? ""))
                            persons.append(person)
                        } else if searchModel.mediaType == "movie" {
                            let movie = MovieModel(popularity: searchModel.popularity, posterPath: IMAGE_URL + (searchModel.posterPath ?? ""), id: searchModel.id, originalTitle: searchModel.originalTitle, title: searchModel.title, voteAverage: searchModel.voteAverage, releaseDate: searchModel.releaseDate, releaseDateString: searchModel.releaseDate?.convertToString(format: "dd.MM.yyyy"))
                            movies.append(movie)
                        }
                    })
                    let searchModel = SearchModel(movies: movies, persons: persons)
                    completion(.success(searchModel))
                    
                }catch {
                    print(error)
                }
                break
            case .failure(let error):
                let errorMessage = self.getResponseError(from: error)
                completion(.failure(errorMessage))
                break
            }
        }
        
    }
}
