//
//  TaskListViewModel.swift
//  TodoList
//
//  Created by Marcus Ramsden on 29/08/2019.
//  Copyright © 2019 Marcus Ramsden. All rights reserved.
//

import struct Combine.Published
import Foundation

class TaskListViewModel {

    private let taskList: TaskList

    init(taskList: TaskList) {
        self.taskList = taskList
    }

    var fetchTasks: Published<[Task]>.Publisher {
        taskList.$tasks
    }

    func addTask() {
        let newTask = Task(summary: "Task \(taskList.count + 1)")
        taskList.add(task: newTask)
    }
}
