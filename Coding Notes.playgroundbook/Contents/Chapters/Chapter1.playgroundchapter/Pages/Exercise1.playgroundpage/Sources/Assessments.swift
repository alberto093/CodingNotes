//
//  Assessments.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//

import PlaygroundSupport

let success = "### Well done!\nYou’ve written the right code to add multiple [notes](glossary://note).\n\n[**Next Page**](@next)"
let initialHint = "You need to write some notes using `addNote()`."
let notFor = "Great job! Now try to use `for` loop."
let wrongNumber = "Remember that notes must be 20."
let solution = "```swift\nfor _ in 0..<20 {\n\n\taddNote()\n\n}"

public func checkAssessment() {
    
    if (PlaygroundPage.current.text.contains("for ") || PlaygroundPage.current.text.contains("repeat") || PlaygroundPage.current.text.contains("...") || PlaygroundPage.current.text.contains("..<")) && counter == 20 {
        
        PlaygroundPage.current.assessmentStatus = .pass(message: success)
        
    } else if !(PlaygroundPage.current.text.contains("for ") || PlaygroundPage.current.text.contains("repeat") || PlaygroundPage.current.text.contains("...") || PlaygroundPage.current.text.contains("..<")) && counter == 20 {
        
        PlaygroundPage.current.assessmentStatus = .fail(hints: [notFor], solution: solution)
        
    } else {
        PlaygroundPage.current.assessmentStatus = .fail(hints: [initialHint, wrongNumber], solution: nil)
    }
}
