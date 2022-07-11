//
//  SearchModel.swift
//  StackOverflow
//
//  Created by Shady K. Maadawy on 09/07/2022.
//

import Foundation

struct QuestionModel : Codable {
    let title : String!
    let score : Int!
    let question_id : Int!
    let is_answered : Bool!
    let answer_count : Int?
    let creation_date : Double!
    let tags: [String]!
    let owner : Owner!
}

struct Owner : Codable {
    let display_name : String!
    let profile_image : String?
}

struct ResponseModel : Codable {
    let items: [QuestionModel]
}
