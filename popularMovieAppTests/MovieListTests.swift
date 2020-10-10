//
//  MovieListTests.swift
//  popularMovieAppTests
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import XCTest
@testable import popularMovieApp

class MovieListTests: XCTestCase {
    
    private var viewModel: MovieListViewModelProtocol!
    private var mockView: MockView!

    override func setUpWithError() throws {
        mockView = MockView()
        viewModel = MovieListViewModel(isMock: true)
        viewModel.delegate = mockView
    }
    
    func testPopularMovies() {
        viewModel.getPopularMovies(page: 1)
        XCTAssertEqual(mockView.outputs.count, 3)
        XCTAssertEqual(mockView.popularMovies.count, 20)
        
        var movie = mockView.popularMovies.first
        movie?.prepareForPresentations()
        XCTAssertEqual(movie?.originalTitle, "Enola Holmes")
        XCTAssertEqual(movie?.releaseDateString, "23.09.2020")
        
    }
    
}

private class MockView: MovieListViewModelDelegate {
    var outputs: [MovieListViewModelOutput] = []
    var popularMovies: [MovieModel]!
    
    func handleMovieListViewModelOutput(_ output: MovieListViewModelOutput) {
        outputs.append(output)
        switch output {
        case .showPopularMovieList(let movieList):
            popularMovies = movieList
            break
        default:
            break
        }
    }
    
    func resetTestOutputs() {
        outputs.removeAll()
    }
    
    func navigate(to route: MovieListRouter) {
    }
}

