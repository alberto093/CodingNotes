//
//  Note.swift
//
//  Copyright © 2019 Alberto Saltarelli. All rights reserved.
//

import UIKit
import Foundation
import PlaygroundSupport

public enum Duration: Float {
    
    case whole = 1, half = 0.5 , quarter = 0.25 , eighth = 0.125 , sixteenth = 0.0625
    
    var description: String {
        switch self {
            case .whole: return "Whole"
            case .half: return "Half"
            case .quarter: return "Quarter"
            case .eighth: return "Eighth"
            case .sixteenth: return "Sixteenth"
        }
    }
}

public enum Frequency: UInt8 {
    
    case C3 = 48, D3 = 50, E3 = 52, F3 = 53, G3 = 55, A3 = 57, B3 = 59, C4 = 60, D4 = 62, E4 = 64, F4 = 65, G4 = 67, A4 = 69, B4 = 71, C5 = 72, D5 = 74, E5 = 76, F5 = 77, G5 = 79, A5 = 81, B5 = 83, C6 = 84
    
    var originY: CGFloat {
        switch self {
            case .C3: return 1539
            case .D3: return 1469
            case .E3: return 1402
            case .F3: return 1332
            case .G3: return 1265
            case .A3: return 1195
            case .B3: return 1125
            case .C4: return 1057
            case .D4: return 991
            case .E4: return 920
            case .F4: return 853
            case .G4: return 784
            case .A4: return 716
            //change orientation from thirdLine
            case .B4: return 953
            case .C5: return 887
            case .D5: return 815
            case .E5: return 750
            case .F5: return 678
            case .G5: return 613
            case .A5: return 540
            case .B5: return 473
            case .C6: return 406
        }
    }
}

public enum Accidental: String {
    
    case flat, sharp
    
    var image: UIImage {
        return UIImage(named: self.rawValue.capitalized)!
    }
}

public struct Note  {
    
    public var duration: Duration
    public var frequency: Frequency
    public var accidental: Accidental?
    public var dots: UInt8?
    public var isReplaced: Bool = false
    var midiNumber: UInt8
    
    var image: UIImage {
        
        if self.duration == .whole {
            return UIImage(named: "Whole")!
        } else {
            return UIImage(named: self.frequency.rawValue >= 71 ? "Upper\(self.duration.description)" : "Lower\(self.duration.description)")!
        }
    }
    
    public var rate: Float {
        
        var value: Float = 0
   
        for i in 0...(self.dots ?? 0) {
            
            value += (self.duration.rawValue * 4) * Float(NSDecimalNumber(decimal: pow(1/2, Int(i))))
        }
        
        return value
    }
    
    var ledgerLinesOriginY: [CGFloat]? {
        
        switch self.frequency {
            case .C3, .D3: return [1432, 1569, 1706, 1843]
            case .E3, .F3: return [1432, 1569, 1706]
            case .G3, .A3: return [1432, 1569]
            case .B3, .C4: return [1432]
            case .A5, .B5: return [610]
            case .C6: return [610, 473]
            default: return nil
        }
    }
    
    var dotOriginY: CGFloat {
        
        switch self.frequency {
            case .C3: return 1901
            case .D3, .E3: return 1764
            case .F3, .G3: return 1627
            case .A3, .B3: return 1487
            case .C4, .D4: return 1353
            case .E4, .F4: return 1215
            case .G4, .A4: return 1078
            case .B4, .C5: return 938
            case .D5, .E5: return 801
            case .F5, .G5: return 664
            case .A5, .B5: return 524
            case .C6: return 390
        }
    }
    
    public init(duration: Duration, frequency: Frequency, accidental: Accidental? = nil, dots: UInt8? = nil) {
        
        self.duration = duration
        self.frequency = frequency
        self.dots = dots
      
        if let accidental = accidental {
            
            self.accidental = accidental
            self.midiNumber = UInt8(Int8(frequency.rawValue) + Int8(accidental == .flat ? -1 : 1))
        } else {
            
            self.midiNumber = frequency.rawValue
        }
    }
}

public extension Note {
    
//    init(playgroundValue: PlaygroundValue) {
//        
//        guard case .dictionary(let dict) = playgroundValue else { return }
//        guard case .floatingPoint(let duration) = dict["Duration"] else { return }
//        guard case .integer(let frequency) = dict["Frequency"] else { return }
//        guard case .string(let accidental) = dict["Accidental"] else { return }
//        guard case .integer(let dots) = dict["Dots"] else { return }
//    
//        self.duration = Duration(rawValue: Float(duration))
//        self.frequency = Frequency(rawValue: UInt8(frequency))
//       
//        if dots != 0 {
//            self.dots = UInt8(dots)
//        }
//        
//        if accidental != "" {
//            self.accidental = Accidental(rawValue: accidental)
//            self.midiNumber = UInt8(Int8(frequency) + Int8(accidental == "flat" ? -1 : 1))
//        } else {
//            self.midiNumber = UInt8(frequency)
//        }
//    }

    var playgroundValue: PlaygroundValue {
        
        return .dictionary(["Duration": PlaygroundValue.floatingPoint(Double(self.duration.rawValue)),
                            "Frequency": PlaygroundValue.integer(Int(self.frequency.rawValue)),
                            "Accidental": PlaygroundValue.string(self.accidental != nil ? self.accidental!.rawValue : ""),
                            "Dots": PlaygroundValue.integer(self.dots != nil ? Int(self.dots!) : 0)])
    }
}

extension Note: CustomStringConvertible {
    
    public var description: String {
        
        return "Duration: \(self.duration),\(self.dots != nil ? " Dots: \(self.dots!)," : "") Frequency: \(self.frequency)\(self.accidental != nil ? ", Accidental: \(self.accidental!)" : "")"
    }
}
