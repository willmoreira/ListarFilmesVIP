//
//  FilmDetailViewTests.swift
//  ListarFilmesVIPTests
//
//  Created by William Moreira on 25/05/23.
//

import XCTest
@testable import ListarFilmesVIP

class FilmDetailViewTests: XCTestCase {
    var filmDetailView: FilmDetailView!
    
    override func setUp() {
        super.setUp()
        filmDetailView = FilmDetailView()
    }
    
    override func tearDown() {
        filmDetailView = nil
        super.tearDown()
    }
    
    func testUpdateFilm() {
        // Given
        let film = ObjectSeeds.result
        filmDetailView.film = film
        
        // When
        filmDetailView.updateFilm()
        
        // Then
        XCTAssertEqual(filmDetailView.titleView.text, film.title)
        XCTAssertEqual(filmDetailView.descriptLabel.text, film.overview)
    }
}
