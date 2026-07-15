//
//  TimeInterval+Extensions.swift
//  ReadItLater
//
//  Created by Mac on 15/07/26.
//

import Foundation

extension TimeInterval {
    
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 2
        
        return formatter.string(from: self) ?? "0 sec"
    }
}
