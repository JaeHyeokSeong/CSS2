//
//  PassGenLangModel.swift
//  CSS2 SEMP PM
//
//  Created by John Underwood on 30/3/2024.
//

struct LanguageRange {
    let start: Int
    let end: Int
    let description: String
}

struct LanguageRangeModel {
    static let shared = LanguageRangeModel()
    
    let ranges: [LanguageRange] = [
        LanguageRange(start: 0x0030, end: 0x0039, description: "Numbers (0-9)"),
        LanguageRange(start: 0x0021, end: 0x002F, description: "Symbols (Subset 1)"),
        LanguageRange(start: 0x003A, end: 0x0040, description: "Symbols (Subset 2)"),
        LanguageRange(start: 0x005B, end: 0x0060, description: "Symbols (Subset 3)"),
        LanguageRange(start: 0x007B, end: 0x007E, description: "Symbols (Subset 4)"),
        LanguageRange(start: 0x0041, end: 0x005A, description: "English (Uppercase)"),
        LanguageRange(start: 0x0061, end: 0x007A, description: "English (Lowercase)"),
        LanguageRange(start: 0x3040, end: 0x309F, description: "Japanese"),
        LanguageRange(start: 0x4E00, end: 0x9FFF, description: "Chinese"),
        LanguageRange(start: 0x0410, end: 0x044F, description: "Russian"),
        LanguageRange(start: 0x0980, end: 0x09FF, description: "Bengali"),
        LanguageRange(start: 0xAC00, end: 0xD7AF, description: "Korean"),
    ]
}

