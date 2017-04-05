//
//  Commands.swift
//
//  Copyright © 2017 Alberto Saltarelli. All rights reserved.
//

import Foundation
import PlaygroundSupport

public var notes: [Note] = []
public var bpm: Int = 80

public func createNotes(frequencies: [Frequency], tempo: Int) {
    
    
    bpm = tempo == 0 ? 32 : abs(tempo)
    
    frequencies.enumerated().forEach { index, freq in
        
        var duration: Duration = .sixteenth
        
        if index == frequencies.count - 1 {
                duration = .quarter
        }
        
        notes.append(Note(duration: duration, frequency: freq))
    }
}
