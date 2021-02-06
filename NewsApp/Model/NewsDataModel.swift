//
//  NewsDataModel.swift
//  NewsApp
//
//  Created by Sapna Bansal on 06/02/21.
//  Copyright © 2021 Sapna Bansal. All rights reserved.
//
import UIKit
import Alamofire
import Foundation

class NewsDataModel:Codable {
        let status: String?
        let totalResults: Int?
        let articles: [Article]?
    }

    // MARK: - Article
    struct Article: Codable {
        let source: Source?
        let author: String?
        let title, articleDescription: String?
        let url: String?
        let urlToImage: String?
//        let publishedAt: Date?
        let content: String?

        enum CodingKeys: String, CodingKey {
            case source, author, title
            case articleDescription = "description"
            case url, urlToImage, content
        }
    }

    // MARK: - Source
    struct Source: Codable {
        let id: String?
        let name: String?
    }
