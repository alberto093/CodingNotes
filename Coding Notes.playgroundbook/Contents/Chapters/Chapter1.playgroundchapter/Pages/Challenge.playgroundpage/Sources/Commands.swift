//
//  Commands.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//

import Foundation
import PlaygroundSupport

var notes: [Note] = []
var currentSong: Song = .americanAnthem
var timeSign: TimeSignature = .fourFour
var bpm: Int = 80
var songInstrument: SoundFont = .piano
var counter = 0

public func createNote(duration: Duration, frequency: Frequency, accidental: Accidental?) -> Note {
    
    var note = Note(duration: duration, frequency: frequency, accidental: accidental)
    note.isReplaced = true
    
    return note
}

public func replaceNote(_ index:Int, with note:Note) {
    let uIndex = abs(index - 1)
    guard uIndex < notes.count else { return }
    counter += 1
    notes[uIndex] = note
}

public func configure(song: Song, tempo: Int, instrument: SoundFont) {
    currentSong = song
    notes = song.notes
    timeSign = song.timeSignature
    bpm = tempo == 0 ? 32 : abs(tempo)
    songInstrument = instrument
}
