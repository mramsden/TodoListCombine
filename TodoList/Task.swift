//
//  Task.swift
//  TodoList
//
//  Created by Marcus Ramsden on 28/08/2019.
//  Copyright © 2019 Marcus Ramsden. All rights reserved.
//

import Foundation

struct Task {
    let id: UUID
    let summary: String

    init(id: UUID = UUID(), summary: String) {
        self.id = id
        self.summary = summary
    }
}
