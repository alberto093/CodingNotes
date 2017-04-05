//
//  Assessments.swift
//
//  Copyright © 2017 Alberto Saltarelli. All rights reserved.
//

import PlaygroundSupport

let success = "### Congratulations!\nYou have good musical skills. \n\nTry the other songs."
let zero = "Listen the song and pay attention to the [accidentals](glossary://accidental).\n\nThen create a note with\n\n `createNote(duration: Duration, frequency: Frequency, accidental: Accidental?) -> Note`\n\nand replace the off-key note with\n\n`replaceNote(_ index:Int, with note:Note)`"
let one = "Great job! You've found one off-key note. Listen again and find the other one!"

let solutionAmerican = "```swift\nlet note1 = createNote(duration: .half, frequency: .F4, accidental: nil)\n\nreplaceNote(12, with: note1)\n\nlet note2 = createNote(duration: .eighth, frequency: .D5, accidental: nil)\n\nreplaceNote(27, with: note2)"

let solutionBolero = "```swift\nlet note1 = createNote(duration: .half, frequency: .G4, accidental: nil)\n\nreplaceNote(18, with: note1)\n\nlet note2 = createNote(duration: .eighth, frequency: .F4, accidental: nil)\n\nreplaceNote(71, with: note2)"

let solutionCanon = "```swift\nlet note1 = createNote(duration: .eighth, frequency: .C5, accidental: .sharp)\n\nreplaceNote(29, with: note1)\n\nlet note2 = createNote(duration: .half, frequency: .D5, accidental: nil)\n\nreplaceNote(136, with: note2)"

let solutionEine = "```swift\nlet note1 = createNote(duration: .half, frequency: .D4, accidental: nil)\n\nreplaceNote(18, with: note1)\n\nlet note2 = createNote(duration: .eighth, frequency: .B4, accidental: nil)\n\nreplaceNote(69, with: note2)"

public func checkAssessment() {
    
    let note1: Note
    let note2: Note
    var fixed = 0
    switch currentSong {
        case .americanAnthem:
            note1 = notes[11]
            note2 = notes[26]
            
            if note1.duration == .half && note1.frequency == .F4 && note1.accidental == nil {
                fixed += 1
            }
            if note2.duration == .eighth && note2.frequency == .D5 && note2.accidental == nil {
                fixed += 1
            }
        
            if fixed == 2 && counter == 2 {
                PlaygroundPage.current.assessmentStatus = .pass(message: success)
            } else if fixed == 1 && (counter == 1 || counter == 2) {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [one, zero], solution: solutionAmerican)
            } else {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [zero], solution: solutionAmerican)
            }
        case .bolero:
            note1 = notes[17]
            note2 = notes[70]
            
            if note1.duration == .half && note1.frequency == .G4 && note1.accidental == nil {
                fixed += 1
            }
            if note2.duration == .eighth && note2.frequency == .F4 && note2.accidental == nil {
                fixed += 1
            }
            
            if fixed == 2 && counter == 2 {
                PlaygroundPage.current.assessmentStatus = .pass(message: success)
            } else if fixed == 1 && (counter == 1 || counter == 2) {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [one, zero], solution: solutionBolero)
            } else {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [zero], solution: solutionBolero)
            }
        case .canonInD:
            note1 = notes[28]
            note2 = notes[135]
            
            if note1.duration == .eighth && note1.frequency == .C5 && note1.accidental == .sharp {
                fixed += 1
            }
            if note2.duration == .half && note2.frequency == .D5 && note2.accidental == nil {
                fixed += 1
            }
            
            if fixed == 2 && counter == 2 {
                PlaygroundPage.current.assessmentStatus = .pass(message: success)
            } else if fixed == 1 && (counter == 1 || counter == 2) {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [one, zero], solution: solutionCanon)
            } else {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [zero], solution: solutionCanon)
            }
        case .eineKleineNachtmusik:
            note1 = notes[17]
            note2 = notes[68]
            
            if note1.duration == .half && note1.frequency == .D4 && note1.accidental == nil {
                fixed += 1
            }
            if note2.duration == .eighth && note2.frequency == .B4 && note2.accidental == nil {
                fixed += 1
            }
            
            if fixed == 2 && counter == 2 {
                PlaygroundPage.current.assessmentStatus = .pass(message: success)
            } else if fixed == 1 && (counter == 1 || counter == 2) {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [one, zero], solution: solutionEine)
            } else {
                PlaygroundPage.current.assessmentStatus = .fail(hints: [zero], solution: solutionEine)
            }
    }
}
