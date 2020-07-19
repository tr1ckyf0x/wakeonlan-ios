//
//  IconSection.swift
//  Wake on LAN
//
//  Created by Dmitry Stavitsky on 28.05.2020.
//  Copyright © 2020 Владислав Лисянский. All rights reserved.
//

import UIKit

// MARK: - IconModel
struct IconModel {
    var pictureName: String = R.image.other.name
}

extension IconModel: Equatable {
    static func == (lhs: IconModel, rhs: IconModel) -> Bool {
        return lhs.pictureName == rhs.pictureName
    }
}

// MARK: - Section Model
enum ChooseIconSectionItem {
    case icon(_ model: IconModel)
}

enum ChooseIconSection {

    typealias Item = FormItem

    case section(header: String? = nil, content: [Item], footer: String? = nil)

    var header: String? {
        switch self {
        case .section(let header, _, _):
            return header
        }
    }

    var content: [Item] {
        switch self {
        case .section(_, let content, _):
            return content
        }
    }

    var footer: String? {
        switch self {
        case .section(_, _, let footer):
            return footer
        }
    }

}
