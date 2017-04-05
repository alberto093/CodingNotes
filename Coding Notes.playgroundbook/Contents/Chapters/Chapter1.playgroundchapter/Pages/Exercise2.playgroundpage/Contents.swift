//#-hidden-code
//
//  Contents.swift
//
//  Copyright © 2017 Alberto Saltarelli. All rights reserved.
//
//#-end-hidden-code
/*:
 **Goal:** Compose the famous iPhone® Marimba Ringtone.
 
 It may look difficult at first, but in reality the song is only made of 4 notes!
 
 1. Pick the right [tempo](glossary://tempo) but keep in mind that time signature is 4/4, thus ♩= BPM.
 
 2. Try to hum the song and type the 12 notes which compose it.
 
 3. Use the hints and listen to the song as much as you need to get the best result.
 
 * callout(Tip):
 The song starts with a [B4](glossary://frequency) and ends with a D5.
 
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, G4, B4, D5, E5)
//#-hidden-code

let G4: Frequency = .G4
let B4: Frequency = .B4
let D5: Frequency = .D5
let E5: Frequency = .E5
//#-end-hidden-code
let tempo = /*#-editable-code*/<#T##bpm##Int#>/*#-end-editable-code*/
let jingle = [/*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/,
              /*#-editable-code*/<#T##frequency##Frequency#>/*#-end-editable-code*/]
//#-hidden-code
createNotes(frequencies: jingle, tempo: tempo)
playgroundStart()
checkAssessment()
//#-end-hidden-code
