//
//  PlaygroundManager.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//

import PlaygroundSupport
import UIKit

func getFlowLayout() -> UICollectionViewFlowLayout {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets.zero
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    return layout
}

var midiPlayer = MIDIPlayer() //It needs to stay outside a scope.

public func playgroundStart() {
    
    let scoreController = ScoreController(collectionViewLayout: getFlowLayout())
    let instrument: SoundFont = .piano
    
    if checkCorrectNotes() == 12 {
        scoreController.notes = Array(repeating: notes, count: 4).flatMap{ $0 }
    } else {
        scoreController.notes = notes
    }
    
    scoreController.bpm = Float(bpm)
    
    if !scoreController.notes.isEmpty {
        
        let musicSequence = MIDISequence(notes: scoreController.notes)
        midiPlayer = MIDIPlayer(musicSequence: musicSequence.getMusicData()!, soundFont: instrument)
        midiPlayer.rate = Float(bpm) / 120
        let fireTime = DispatchTime.now() + 1
        
        DispatchQueue.main.asyncAfter(deadline: fireTime, execute: {
            scoreController.startTimer(timeInterval: (musicSequence.minimumDuration! * 60 / Double(bpm)))
        })
        DispatchQueue.main.asyncAfter(deadline: fireTime, execute: {
            midiPlayer.playSequence {
                //PlaygroundPage.current.finishExecution()
            }
        })
    }
    PlaygroundPage.current.liveView = scoreController
    PlaygroundPage.current.needsIndefiniteExecution = true
    
    
}
