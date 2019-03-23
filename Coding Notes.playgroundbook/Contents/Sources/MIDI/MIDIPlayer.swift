//
//  MIDIPlayer.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//

import AVFoundation

public enum SoundFont: String {
    case piano, trumpet, flute, guitar, violin, panFlute
}

public class MIDIPlayer {
    
    private var midiPlayer: AVMIDIPlayer?
    
    public var rate: Float? {
        get {
            return self.midiPlayer?.rate
        }
        set {
            self.midiPlayer?.rate = newValue ?? 1
        }
    }
    
    public var duration: TimeInterval? {
        get {
            if let midiPlayer = self.midiPlayer {
                return midiPlayer.duration / Double(midiPlayer.rate)
            } else {
                return nil
            }
        }
    }
    
    public init() {
        
    }
    
    public init(musicSequence: Data, soundFont: SoundFont) {
        guard let bankURL = Bundle.main.url(forResource: "SoundFont/" + soundFont.rawValue.capitalized, withExtension: "sf2") else { return }
        
        do {
            try self.midiPlayer = AVMIDIPlayer(data: musicSequence, soundBankURL: bankURL)
        } catch {
            fatalError("Failed To Load Player.\n\(error)")
        }
        
        self.midiPlayer?.prepareToPlay()
    }
    
    public func playSequence(completionHandler completion: @escaping AVMIDIPlayerCompletionHandler) {
        
        guard let midiPlayer = self.midiPlayer else {
            DispatchQueue.main.async(execute: completion)
            return
        }
 
        midiPlayer.play(completion)
    }
}
