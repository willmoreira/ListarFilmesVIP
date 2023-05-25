//
//  ResultSeeds.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 25/05/23.
//

import Foundation
@testable import ListarFilmesVIP


class ObjectSeeds {
    
    static let result = Result(
        adult: false,
        backdropPath: "/image.jpg",
        genreIDS: [1,2,3],
        id: 1,
        originalLanguage: "en",
        originalTitle: "Movie",
        overview: "Description",
        popularity: 1.2,
        posterPath: "/image.jpg",
        releaseDate: "2021-05-11",
        title: "Movie",
        video: false,
        voteAverage: 7.5,
        voteCount: 500)
}
