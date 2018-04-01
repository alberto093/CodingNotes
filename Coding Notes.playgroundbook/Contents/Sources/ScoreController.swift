//
//  ScoreController.swift
//
//  Copyright © 2017 Alberto Saltarelli. All rights reserved.
//

import UIKit

public class ScoreController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    public var notes: [Note] = []
    public var tempo: TimeSignature!
    public var bpm: Float!
    public var isChallenge = false
    private var playbackTimer: Timer!
    private var noteFireTime: TimeInterval = 0
    private var currentNote: Int = 0
    private var currentTime: TimeInterval = 0
    private var isDoubleColumn = false
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureCollectionView()
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let collectionView = object as? UICollectionView, collectionView == self.collectionView! && keyPath == "frame" else { return }
        
        self.collectionView!.reloadData()
        
        if let timer = self.playbackTimer, timer.isValid {
            self.collectionView?.scrollToItem(at: self.indexPathForItem(noteIndex: self.currentNote)!, at: .top, animated: false)
        }
    }
    
    private func configureCollectionView() {
        guard let collectionView = self.collectionView else { return }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ScoreCell.self, forCellWithReuseIdentifier: "scoreCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.isUserInteractionEnabled = false
        collectionView.backgroundView = UIImageView(image: UIImage(named: "Background"))
        collectionView.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions(rawValue: 0), context: nil)
    }
    
    public func addNote(duration: Duration, frequency: Frequency, accidental: Accidental? = nil, dots: UInt8? = nil) {
        
        self.notes.append(Note(duration: duration, frequency: frequency, accidental: accidental, dots: dots))
    }
    
    public func startTimer(timeInterval: TimeInterval) {
        guard !self.notes.isEmpty else { return }
        
        self.playbackTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.updateUI(_:)), userInfo: nil, repeats: true)
        self.noteFireTime = TimeInterval(self.notes.first!.rate * 60 / self.bpm)
        
        if let cell = self.collectionView!.cellForItem(at: IndexPath(item: 0, section: 0)) as? ScoreCell, let note = cell.viewWithTag(100) as? UIImageView {
            note.update(isPlaying: true)
        }
    }
    
    private func changePlayNote() {
        
        if let cell = self.collectionView!.cellForItem(at: self.indexPathForItem(noteIndex: self.currentNote)!) as? ScoreCell {
            var note = cell.viewWithTag(100 + self.currentNote) as? UIImageView
            note?.update(isPlaying: true)
            
            if let currentCell = cell.viewWithTag(100 + self.currentNote - 1) as? UIImageView {
                note = currentCell.viewWithTag(100 + self.currentNote - 1) as? UIImageView
                note?.update(isPlaying: false)
            } else if let previousCell = self.collectionView!.cellForItem(at: self.indexPathForItem(noteIndex: self.currentNote - 1)!) as? ScoreCell, let previousNote = previousCell.viewWithTag(100 + self.currentNote - 1) as? UIImageView {
                
                previousNote.update(isPlaying: false)
            }
        }
    }
    
    @discardableResult private func scrollScore(isDoubleColumn: Bool) -> Bool {
        // Check if playing note is the last of the staff's row
        if isDoubleColumn && ((self.currentNote - 6) % 7 == 0 && ((self.currentNote - 6) / 7) % 2 != 0) || !isDoubleColumn && (self.currentNote == 6 || (self.currentNote - 6) % 7  == 0) {
            
            if let indexPath = self.indexPathForItem(noteIndex: self.currentNote), self.collectionView!.numberOfItems(inSection: indexPath.section) >= indexPath.item  {
                
                self.collectionView!.scrollToItem(at: indexPath, at: .top, animated: true)
                return true
            }
        }
        return false
    }
    
    @objc private func updateUI(_ timer: Timer) {
        
        self.currentTime += timer.timeInterval
        
        if self.currentTime >= self.noteFireTime {
            guard self.currentNote != self.notes.count - 1 else {
                
                self.playbackTimer.invalidate()
                self.collectionView!.isUserInteractionEnabled = true
                
                if let cell = self.collectionView!.cellForItem(at: self.indexPathForItem(noteIndex: self.currentNote)!) as? ScoreCell, let note = cell.viewWithTag(100 + self.currentNote) as? UIImageView {
                    note.update(isPlaying: false)
                }
                
                return
            }
            
            self.currentNote += 1
            self.noteFireTime += TimeInterval(self.notes[self.currentNote].rate * 60 / self.bpm)
            self.changePlayNote()
            self.scrollScore(isDoubleColumn: self.isDoubleColumn)
        }
    }
    
    private func indexPathForItem(noteIndex: Int) -> IndexPath? {
        
        guard noteIndex < self.notes.count else { return nil }
        
        if noteIndex < 6 {
            return IndexPath(item: 0, section: 0)
        } else {
            return IndexPath(item: (noteIndex + 1) / 7, section: 0)
        }
    }
    
    //MARK: CollectionViewFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.view.frame.width < self.view.frame.height && self.view.frame.width < 768 { //iPadAir.screen.main.bounds.width = 768
            self.isDoubleColumn = false
            return CGSize(width: self.view.frame.width, height: self.view.frame.height / 2)
        } else {
            self.isDoubleColumn = true
            return CGSize(width: self.view.frame.width / 2, height: self.view.frame.height / 2)
        }
    }
    
    //MARK: CollectionView
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.notes.count != 0 else { return 4 }
        return self.notes.count <= 6 ? 1 : 1 + Int((Double(self.notes.count - 6) / Double(7)).rounded(.awayFromZero))
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scoreCell", for: indexPath) as! ScoreCell
        cell.backgroundImage.contentMode = .scaleAspectFit
        cell.backgroundImage.frame = cell.bounds
        cell.backgroundImage.subviews.forEach { $0.removeFromSuperview()}
        
        let scaleFactor = cell.backgroundImage.contentScaleFactor
        
        if (self.isDoubleColumn && indexPath.item % 2 == 0) || !self.isDoubleColumn {
            
            let key = UIImageView(image: UIImage(named: "TrebleClef"))
            key.contentScaleFactor = scaleFactor
            key.frame.origin = CGPoint(x: cell.backgroundImage.imageFrame.origin.x + 44 * scaleFactor, y: cell.backgroundImage.imageFrame.origin.y + 507 * scaleFactor)
            cell.backgroundImage.addSubview(key)
            cell.isClefVisibile = true
        } else {
            cell.isClefVisibile = false
        }
        
        if self.notes.count > 0 {
            switch indexPath.item {
            case 0:
                let tempoView: UIImageView
                
                if let tempo = self.tempo {
                    tempoView = UIImageView(image: UIImage(named: tempo.description))
                } else {
                    tempoView = UIImageView(image: UIImage(named: "4:4"))
                }
                
                tempoView.contentMode = .scaleAspectFit
                tempoView.contentScaleFactor = scaleFactor
                tempoView.frame.origin = CGPoint(x: cell.backgroundImage.imageFrame.origin.x + 500 * scaleFactor, y: cell.backgroundImage.imageFrame.origin.y + 754 * scaleFactor)
                
                cell.backgroundImage.addSubview(tempoView)
                
                if !self.notes.isEmpty {
                    let range = self.notes.count > 6 ? 0...5 : 0...self.notes.count - 1
                    cell.notes = Array(self.notes[range])
                }
                
                if indexPath.item == self.collectionView!.numberOfItems(inSection: indexPath.section) - 1 {
                    fallthrough
                }
            case self.collectionView!.numberOfItems(inSection: indexPath.section) - 1:
                let boldLine = UIImageView(image: UIImage(named: "BoldBarLine"))
                boldLine.contentScaleFactor = scaleFactor
                boldLine.frame.origin = (CGPoint(x: cell.backgroundImage.imageFrame.origin.x + 2688 * scaleFactor, y: cell.backgroundImage.imageFrame.origin.y + 747 * scaleFactor))
                cell.backgroundImage.addSubview(boldLine)
                if indexPath.item != 0 {
                    fallthrough
                }
            default:
                let range = self.notes.count > 7 * indexPath.row + 5 ? 7 * indexPath.row - 1...7 * indexPath.row + 5 : 7 * indexPath.row - 1...self.notes.count - 1
                cell.notes = Array(self.notes[range])
            }
            
            cell.configureNotes(with: indexPath.item, isCountVisible: self.isChallenge)
        }
        cell.backgroundImage.contentMode = self.view.frame.width < self.view.frame.height ? .scaleAspectFit : .scaleToFill
        
        return cell
    }
}
