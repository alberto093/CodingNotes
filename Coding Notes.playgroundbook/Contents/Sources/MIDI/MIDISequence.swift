//
//  MIDISequence.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//

import AudioToolbox

public class MIDISequence {
    
    private var musicSequence:MusicSequence?
    public private(set) var minimumDuration: MusicTimeStamp?
    
    public init(notes: [Note]) {
        
        guard !notes.isEmpty else { return }
        NewMusicSequence(&self.musicSequence)
        
        if let sequence = self.musicSequence  {
            
            var track: MusicTrack?
            
            MusicSequenceNewTrack(sequence, &track)
            
            if let track = track {
                
                var time: MusicTimeStamp = 0
                self.minimumDuration = MusicTimeStamp(Int64.max)
                
                notes.enumerated().forEach { index, note in
                    
                    self.addNote(toTrack: track, beat: time, channel: 0, note: note.midiNumber, velocity: 64, releaseVelocity: 0, duration: note.rate)
                    self.minimumDuration = min(self.minimumDuration!, MusicTimeStamp(note.rate))
                    time += MusicTimeStamp(note.rate)
                }
            }
        }
    }
    
    public func getMusicSequence() -> MusicSequence? {
        return self.musicSequence
    }
    
    public func getMusicData() -> Data? {
        guard let musicSequence = self.musicSequence else { return nil }
        
        var data:Unmanaged<CFData>?
        
        MusicSequenceFileCreateData(musicSequence, .midiType, .eraseFile, 480, &data)
        
        if let data = data {
            return data.takeUnretainedValue() as Data
        }
        
        return nil
    }
    
    public func getTrack(_ trackIndex:Int) -> MusicTrack? {
        guard let sequence = self.musicSequence else { return nil }
        
        var track:MusicTrack?
        
        MusicSequenceGetIndTrack(sequence, UInt32(trackIndex), &track)
        
        return track
    }
    
    public func addNote(trackIndex:Int, beat:MusicTimeStamp, channel:UInt8, note:UInt8, velocity:UInt8, releaseVelocity:UInt8, duration:Float32) {
        guard let track = self.getTrack(trackIndex) else { return }
        
        self.addNote(toTrack: track, beat: beat, channel: channel, note: note, velocity: velocity, releaseVelocity: releaseVelocity, duration: duration)
    }
    
    public func addNote(toTrack track:MusicTrack, beat:MusicTimeStamp, channel:UInt8, note:UInt8, velocity:UInt8, releaseVelocity:UInt8, duration:Float32) {
        
        var mess = MIDINoteMessage(channel: channel, note: note, velocity: velocity, releaseVelocity: releaseVelocity, duration: duration)
        
        MusicTrackNewMIDINoteEvent(track, beat, &mess)
    }
}
