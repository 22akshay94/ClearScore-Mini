//
//  CreditScoreModel.swift
//  ClearScore-Mini
//
//  Created by Akshay Yerneni on 21/01/2022.
//

import Foundation

struct CreditScore: Decodable {
    let creditReportInfo: CreditReportInfo
}

struct CreditReportInfo: Decodable {
    let score: Int
    let maxScoreValue: Int
    let minScoreValue: Int
    let currentShortTermCreditLimit: Int
    let equifaxScoreBandDescription: String
    let daysUntilNextReport: Int
}
