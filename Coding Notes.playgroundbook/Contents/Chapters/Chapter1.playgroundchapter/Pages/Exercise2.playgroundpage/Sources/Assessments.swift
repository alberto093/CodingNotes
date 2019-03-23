//
//  Assessments.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//

import PlaygroundSupport

let success = "### Amazing!\nYou’ve played the iPhone® Marimba Ringtone. Your musical skills are growing.\n\n[**Next Page**](@next)"
let tooLow = "Perfect! Loop is correct. Try to increase [tempo](glossary://tempo)."
let tooHigh = "Perfect! Loop is correct but tempo is too high! Relax and try to decrease [tempo](glossary://tempo)."
let justOne = "Powerful! Just one missed note. Listen and fix it."
let upToTen = "Great job! Solution is coming."
let fewNotes = "Good! Remember that notes are just four and every note is different from its previous and its successive."
let zero = "Key is G major. Try to use G4, B4, D5, E5 starting with B4"
let solutionTempo = "♩= 88\n\n`let` tempo = 88"
let solutionJingle = "B4, G4, D5, G4, D5, E5, D5, G4, E5, D5, G4, D5"

public func checkCorrectNotes() -> Int {
    
    let sequence: [Frequency] = [.B4, .G4, .D5, .G4, .D5, .E5, .D5, .G4, .E5, .D5, .G4, .D5]
    
    return notes.enumerated().reduce(0) { (result, offsetNote) -> Int in
        if offsetNote.element.frequency == sequence[offsetNote.offset] {
            return result + 1
        } else {
            return result
        }
    }
}

public func checkAssessment() {
    
    let lowerRange = 1..<78
    let correctRange = 78..<99
    
    let correctNotes = checkCorrectNotes()
    
    switch correctNotes {
        case 0:
            PlaygroundPage.current.assessmentStatus = .fail(hints: [zero], solution: solutionJingle)
        case 1...6:
            PlaygroundPage.current.assessmentStatus = .fail(hints: [zero, fewNotes], solution: solutionJingle)
        case 7...10:
            PlaygroundPage.current.assessmentStatus = .fail(hints: [upToTen, zero, fewNotes], solution: solutionJingle)
        case 11:
            PlaygroundPage.current.assessmentStatus = .fail(hints: [justOne, zero, fewNotes.substring(from: fewNotes.index(fewNotes.startIndex, offsetBy: 6))], solution: solutionJingle)
        case 12:
            if correctRange.contains(bpm) {
                PlaygroundPage.current.assessmentStatus = .pass(message: success)
            } else if lowerRange.contains(bpm) {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [tooLow], solution: solutionTempo)
            } else {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [tooHigh], solution: solutionTempo)
            }
        default: return
    }
}
