//
//  TaskList.swift
//  TodoList
//
//  Created by Marcus Ramsden on 28/08/2019.
//  Copyright © 2019 Marcus Ramsden. All rights reserved.
//

import Foundation

class TaskList {

    private(set) var tasks = [Task]()

    func add(task: Task) {
        tasks.append(task)
    }

    var count: Int {
        return tasks.count
    }
}
