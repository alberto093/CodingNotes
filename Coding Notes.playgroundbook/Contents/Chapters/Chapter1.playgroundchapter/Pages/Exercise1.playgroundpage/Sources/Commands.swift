//
//  Commands.swift
//
//  Copyright © 2017 Alberto Saltarelli. All rights reserved.
//

import Foundation
import PlaygroundSupport

var notes: [Note] = []
var counter = 0

let durations: [Float] = [0.5, 0.25, 0.125, 0.0625]
let frequencies: [UInt8] = [57, 59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76, 77]

public func addNote() {
    counter += 1
    notes.append(Note(duration: Duration(rawValue: durations[Int(arc4random_uniform(UInt32(durations.count)))])!, frequency: Frequency(rawValue: frequencies[Int(arc4random_uniform(UInt32(frequencies.count)))])!))
}
