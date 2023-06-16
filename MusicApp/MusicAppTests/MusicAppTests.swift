//
//  MusicAppTests.swift
//  MusicAppTests
//
//  Created by Emine Sinem on 6.06.2023.
//

import MusicAPI
import XCTest
@testable import MusicApp

final class DetailPresenterTests: XCTestCase {
    
    var view: MockDetailViewController!
    var interactor: MockDetailInteractor!
    var presenter: DetailPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.view = MockDetailViewController()
        self.interactor = MockDetailInteractor()
        self.presenter = DetailPresenter(view: view, interactor: interactor, router: DetailRouter())
        
    }

    func testViewDidLoad() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        presenter.viewDidLoad()
        XCTAssert(interactor.isViewDidLoad == true)
        
        presenter.showMusicDetail(Music.mocked, isLiked: false)
        XCTAssert(view.imageURL?.absoluteString == Music.mocked.artworkUrl100)
        XCTAssert(view.singerName == Music.mocked.artistName)
        XCTAssert(view.collectionLabel == Music.mocked.collectionName)
        XCTAssert(view.songName == Music.mocked.trackName)
        XCTAssert(view.songType == Music.mocked.primaryGenreName)
        XCTAssert(view.trackPrice == "Track Price: $ \(Music.mocked.trackPrice!)")
        XCTAssert(view.collectionPrice == "Collection Price: $ \(Music.mocked.collectionPrice!)")
    }
    
    func testPlayButtonClicked() throws {
        presenter.playButtonClicked()
        XCTAssert(interactor.isPlayButtonClicked == true)
        
        presenter.updatePlayButton(isPlaying: true)
        XCTAssert(view.playing == true)
    }
    
    func testLikeButtonClicked() throws {
        presenter.likeButtonClicked()
        XCTAssert(interactor.isLikeButtonClicked == true)
        
        presenter.updateLikeButton(isLiked: true)
        XCTAssert(view.liked == true)
    }
}

class MockDetailViewController: DetailViewControllerProtocol {
    var liked: Bool = false
    var playing: Bool = false
    var singerName = ""
    var collectionLabel = ""
    var playingMusicURL: String?
    var songName = ""
    var songType = ""
    var trackPrice = ""
    var collectionPrice = ""
    var imageURL: URL?
    
    func changeLike(_ liked: Bool) {
        self.liked = liked
    }
    
    func changePlay(_ playing: Bool) {
        self.playing = playing
    }
    
    func setSingerNameLabel(_ text: String) {
        singerName = text
    }
    
    func setCollectionLabel(_ text: String) {
        collectionLabel = text
    }
    
    func playMusic(_ url: String) {
        playingMusicURL = url
    }
    
    func setSongNameLabel(_ text: String) {
        songName = text
    }
    
    func setSongTypeLabel(_ text: String) {
        songType = text
    }
    
    func setTrackPriceLabel(_ text: String) {
        trackPrice = text
    }
    
    func setCollectionPriceLabel(_ text: String) {
        collectionPrice = text
    }
    
    func setImg(url: URL) {
        imageURL = url
    }
}

class MockDetailInteractor: DetailInteractorProtocol {
    var isViewDidLoad = false
    var isPlayButtonClicked = false
    var isLikeButtonClicked = false
    var isMusicStopped = false
    
    func viewDidLoad() {
        isViewDidLoad = true
    }
    
    func playButtonClicked() {
        isPlayButtonClicked = true
    }
    
    func likeButtonClicked() {
        isLikeButtonClicked = true
    }
    
    func stopMusic() {
        isMusicStopped = true
    }
    
    
}

extension Music {
    static var mocked: Music {
        Music(artistID: nil, collectionID: nil, trackID: nil, wrapperType: nil, kind: nil, artistName: "Tarkan", collectionName: "Collection", trackName: "Kuzu Kuzu", collectionCensoredName: nil, trackCensoredName: nil, artistViewURL: nil, collectionViewURL: nil, trackViewURL: nil, previewURL: "https://www.preview.com", artworkUrl30: nil, artworkUrl60: nil, artworkUrl100: "https://www.artwork.com", collectionPrice: 100, trackPrice: 50, releaseDate: nil, collectionExplicitness: nil, trackExplicitness: nil, discCount: nil, discNumber: nil, trackCount: nil, trackNumber: nil, trackTimeMillis: nil, country: nil, currency: "$", primaryGenreName: "Pop", isStreamable: nil)
    }
}
