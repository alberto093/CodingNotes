//
//  ScoreCell.swift
//
//  Copyright © 2017 Alberto Saltarelli. All rights reserved.
//

import UIKit

public class ScoreCell: UICollectionViewCell {
    var notes: [Note]?
    var backgroundImage: UIImageView!
    var isClefVisibile: Bool!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundImage = UIImageView(frame: frame)
        self.backgroundImage.image = UIImage(named: "Pentagram")
        self.backgroundImage.contentMode = .scaleAspectFit
        self.addSubview(self.backgroundImage)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLedgerLines(note: Note, noteOriginX: CGFloat) {
        
        if let ledgerLines = note.ledgerLinesOriginY {
            let deltaX = note.duration == .whole ? 16 * self.backgroundImage.contentScaleFactor : 26 * self.backgroundImage.contentScaleFactor
            ledgerLines.forEach {
                
                let lineView = UIImageView(image: UIImage(named: "LedgerLine"))
                lineView.contentScaleFactor = self.backgroundImage.contentScaleFactor
                let lineOriginX = noteOriginX - deltaX
                let lineOriginY =  self.backgroundImage.imageFrame.origin.y + ($0 * self.backgroundImage.contentScaleFactor)
                
                lineView.frame.origin = CGPoint(x: lineOriginX, y: lineOriginY)
                self.backgroundImage.insertSubview(lineView, at: 0)
            }
        }
    }
    
    private func addAccidental(note: Note, noteOriginX: CGFloat, noteOriginY: CGFloat) {
        
        if let accidental = note.accidental {
            let deltaX = 125 * self.backgroundImage.contentScaleFactor
            
            let deltaY = (note.frequency.rawValue >= 71 || note.duration == .whole ? accidental == .flat ? -130 : -64 : accidental == .flat ? 185 : 251) * self.backgroundImage.contentScaleFactor
            
            let accView = UIImageView(image: accidental.image)
            accView.contentScaleFactor = self.backgroundImage.contentScaleFactor
            let accOriginX = noteOriginX - deltaX
            let accOriginY = noteOriginY + deltaY
            
            accView.frame.origin = CGPoint(x: accOriginX, y: accOriginY)
            self.backgroundImage.addSubview(accView)
            
        }
    }
    
    private func addDots(note: Note, noteOriginX: CGFloat) {
        
        if let dots = note.dots {
            
            let deltaX = 185 * self.backgroundImage.contentScaleFactor
            let deltaDotX = 60 * self.backgroundImage.contentScaleFactor
            for indexDot in 0..<dots {
                let dotView = UIImageView(image: UIImage(named: "Dot"))
                dotView.contentScaleFactor = self.backgroundImage.contentScaleFactor
                dotView.frame.origin = CGPoint(x: noteOriginX + (indexDot == 0 ? deltaX : deltaDotX), y: self.backgroundImage.imageFrame.origin.y + note.dotOriginY * self.backgroundImage.contentScaleFactor)
                
                self.backgroundImage.addSubview(dotView)
            }
        }
    }
    
    private func adjust(note: Note, noteOriginX: CGFloat, noteOriginY: CGFloat) {
        
        self.addLedgerLines(note: note, noteOriginX: noteOriginX)
        self.addAccidental(note: note, noteOriginX: noteOriginX, noteOriginY: noteOriginY)
        self.addDots(note: note, noteOriginX: noteOriginX)
    }
    
    func configureNotes(with index: Int, isCountVisible: Bool) {
        
        let scaleFactor = self.backgroundImage.contentScaleFactor
        var noteOriginX = self.backgroundImage.imageFrame.origin.x + (index == 0 ? 500 : (self.isClefVisibile == true ? 170 : -190)) * scaleFactor
        
        self.notes?.enumerated().forEach { indexNote, note in
            
            let noteView = UIImageView(image: note.image)
            
            noteView.tag = 100 + (index == 0 ? indexNote : 6 + (7 * (index - 1)) + indexNote)
            noteView.contentScaleFactor = scaleFactor
            
            noteOriginX += note.accidental != nil ? 375 * scaleFactor : 300 * scaleFactor
            
            var noteOriginY = self.backgroundImage.imageFrame.origin.y + note.frequency.originY * scaleFactor
            noteOriginY += note.duration == .whole && note.frequency.rawValue < 71 ? 307 * scaleFactor : 0
            
            noteView.frame.origin = CGPoint(x: noteOriginX, y: noteOriginY)
            
            if note.isReplaced {
                noteView.layer.shadowColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1).cgColor
                noteView.layer.shadowOffset = .zero
                noteView.layer.shadowOpacity = 1
                noteView.layer.shadowRadius = 4
            } else {
                noteView.layer.shadowColor = nil
                noteView.layer.shadowRadius = 0
            }
            
            if isCountVisible {
                let label = UILabel()
                label.text = "\((index == 0 ? indexNote + 1 : 6 + (7 * (index - 1)) + indexNote + 1))"
                label.textColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
                label.font = UIFont.boldSystemFont(ofSize: 17)
                label.sizeToFit()
                
                if note.duration == .whole || note.frequency.rawValue >= 71 {
                    label.frame.origin = CGPoint(x: noteOriginX + (noteView.frame.width / 2) - (label.frame.width / 2), y: noteOriginY - label.frame.height - 5)
                } else {
                    label.frame.origin = CGPoint(x: noteOriginX + (noteView.frame.width / 2) - (label.frame.width / 2), y: noteOriginY + noteView.frame.height + 5)
                }
                
                self.backgroundImage.addSubview(label)
            }
            
            self.backgroundImage.addSubview(noteView)
            
            self.adjust(note: note, noteOriginX: noteOriginX, noteOriginY: noteOriginY)
        }
    }
}
