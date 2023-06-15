//
//  ResultSeeds.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 25/05/23.
//

import Foundation
@testable import ListarFilmesVIP


class ObjectSeeds {
    static let filmModelConvertedDate = FilmModel(
        page: 0,
        results: [resultDateConvertedDate],
        totalPages: 1,
        totalResults: 1)
    
    static let filmModel = FilmModel(
        page: 0,
        results: [result],
        totalPages: 1,
        totalResults: 1)
    
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
    
    static let resultDateConvertedDate = Result(
        adult: false,
        backdropPath: "/image.jpg",
        genreIDS: [1,2,3],
        id: 1,
        originalLanguage: "en",
        originalTitle: "Movie",
        overview: "Description",
        popularity: 1.2,
        posterPath: "/image.jpg",
        releaseDate: "11 de maio de 2021",
        title: "Movie",
        video: false,
        voteAverage: 7.5,
        voteCount: 500)
}
