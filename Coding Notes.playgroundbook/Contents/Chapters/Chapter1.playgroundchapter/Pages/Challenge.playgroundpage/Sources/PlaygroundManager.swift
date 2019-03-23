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

public func playgroundInit() {
    
    let scoreController = ScoreController(collectionViewLayout: getFlowLayout())
    
    scoreController.notes = notes
    scoreController.bpm = Float(bpm)
    scoreController.isChallenge = true
    
    if !scoreController.notes.isEmpty {
        
        scoreController.tempo = timeSign
        let musicSequence = MIDISequence(notes: scoreController.notes)
        midiPlayer = MIDIPlayer(musicSequence: musicSequence.getMusicData()!, soundFont: songInstrument)
        midiPlayer.rate = Float(bpm) / 120
        
        let fireTime = DispatchTime.now() + 1
        
        DispatchQueue.main.asyncAfter(deadline: fireTime, execute: {
            midiPlayer.playSequence {
                //PlaygroundPage.current.finishExecution()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: fireTime, execute: {
            scoreController.startTimer(timeInterval: (musicSequence.minimumDuration! * 60 / Double(bpm)))
        })
    }
    PlaygroundPage.current.liveView = scoreController
    PlaygroundPage.current.needsIndefiniteExecution = true
    
    
}
