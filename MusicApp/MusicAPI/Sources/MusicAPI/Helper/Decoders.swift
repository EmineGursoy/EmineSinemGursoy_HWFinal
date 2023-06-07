//
//  Decoders.swift
//  
//
//  Created by Emine Sinem on 6.06.2023.
//

import Foundation

public enum Decoders {
    static let dateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
