//
//  DetailInteractor.swift
//  MusicApp
//
//  Created by Emine Sinem on 9.06.2023.
//

import AVFoundation
import Foundation
import MusicAPI
import CoreData
import UIKit

protocol DetailInteractorProtocol {
    func viewDidLoad()
    func playButtonClicked()
    func likeButtonClicked()
    func stopMusic()
}

protocol DetailInteractorOutputProtocol {
    func showMusicDetail(_ music: Music, isLiked: Bool)
    func updatePlayButton(isPlaying: Bool)
    func updateLikeButton(isLiked: Bool)
}

final class DetailInteractor: DetailInteractorProtocol {
    var output: DetailInteractorOutputProtocol?
    var source: Music
    
    var player: AVPlayer?
    var isPlaying: Bool = false
    
    init(source: Music) {
        self.source = source
    }
    
    func playButtonClicked() {
        if isPlaying {
            player?.pause()
            player = nil
            isPlaying = false
            output?.updatePlayButton(isPlaying: false)
        } else {
            let music = source
            let urlString = music.previewURL ?? ""
            
            guard let url = URL(string: urlString) else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                player = try AVPlayer(url: url as URL)
                player?.volume = 5.0
                guard let player = player else { return }
                player.play()
                isPlaying = true
                output?.updatePlayButton(isPlaying: true)

            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func stopMusic() {
        player?.pause()
        player = nil
        isPlaying = false
        output?.updatePlayButton(isPlaying: false)
    }
    
    func viewDidLoad() {
        output?.showMusicDetail(source, isLiked: isMusicLiked())
    }
    
    func likeButtonClicked() {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate,
              let trackID = source.trackID else { return}
        
        let persistentViewContext = applicationDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LikedMusic> = LikedMusic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackId == %@", Int64(trackID) as NSNumber)
        
        do {
            let fetchedLikedMusic = try persistentViewContext.fetch(fetchRequest)
            
            if let liked = fetchedLikedMusic.first {
                persistentViewContext.delete(liked)
                output?.updateLikeButton(isLiked: false)
            } else {
                let newLiked = LikedMusic(context: persistentViewContext)
                newLiked.trackId = Int64(trackID)
                output?.updateLikeButton(isLiked: true)
            }
            
            try persistentViewContext.save()
        } catch {
            print("Core data hatasi: \(error)")
        }
    }
    
    func isMusicLiked() -> Bool {
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate,
              let trackID = source.trackID else { return false }
        
        let persistentViewContext = applicationDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<LikedMusic> = LikedMusic.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackId == %@", Int64(trackID) as NSNumber)
        
        do {
            let fetchedLikedMusic = try persistentViewContext.fetch(fetchRequest)
            
            if let liked = fetchedLikedMusic.first {
                return true
            } else {
                return false
            }
        } catch {
            print("Core data hatasi: \(error)")
            
            return false
        }
    }
}
