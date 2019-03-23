//#-hidden-code
//
//  Contents.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//
//#-end-hidden-code
/*:
 **Goal:** Fix the original music scores.
 
 Put your listening skills to the test and find the 2 mistakes in each piece.
 Have fun picking your own BPM and your favourite instrument!
 
 1. Listen to the song and memorise the number of the note to modify.
 
 2. Create the correct note using the `createNote(duration:frequency:accidental:)` method.
 
 3. Fix the off-key note using the `replaceNote(_:with:)` method.
 
 * callout(Tip):
 Look out for [accidentals](glossary://accidental)! Most off-key notes actually depend on this.
 
 */
//#-code-completion(currentmodule, show)
//#-code-completion(identifier, show, let, =, ., var, createNote(duration:frequency:accidental:), replaceNote(_:with:), americanAnthem, bolero, canonInD, eineKleineNachtmusik, piano, trumpet, violin, panFlute, flute, guitar)
//#-hidden-code
let americanAnthem: Song = .americanAnthem
let bolero: Song = .bolero
let canonInD: Song = .canonInD
let eineKleineNachtmusik: Song = .eineKleineNachtmusik
let piano: SoundFont = .piano
let trumpet: SoundFont = .trumpet
let violin: SoundFont = .violin
let panFlute: SoundFont = .panFlute
let flute: SoundFont = .flute
let guitar: SoundFont = .guitar
//#-end-hidden-code
let song: Song = /*#-editable-code*/<#T##song##Song#>/*#-end-editable-code*/
let tempo: Int = /*#-editable-code*/<#T##bpm##Int#>/*#-end-editable-code*/
let instrument: SoundFont = /*#-editable-code*/<#T##instrument##SoundFont#>/*#-end-editable-code*/
//#-hidden-code
configure(song: song, tempo: tempo, instrument: instrument)
//#-end-hidden-code
/*:
 Tap on `▶ Run My Code` to listen to the song and fix the off-key notes after you are done.
 
 */
//#-editable-code Tap to write your code

//#-end-editable-code
//#-hidden-code
playgroundInit()
checkAssessment()
//#-end-hidden-code
