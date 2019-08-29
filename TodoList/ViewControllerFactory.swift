//
//  ViewControllerFactory.swift
//  TodoList
//
//  Created by Marcus Ramsden on 28/08/2019.
//  Copyright © 2019 Marcus Ramsden. All rights reserved.
//

import UIKit

class ViewControllerFactory {

    private let taskList: TaskList

    init(taskList: TaskList) {
        self.taskList = taskList
    }

    func makeTaskList() -> TaskListViewController {
        let taskListViewController = TaskListViewController()
        taskListViewController.viewModel = TaskListViewModel(taskList: taskList)
        return taskListViewController
    }

    func makeRootNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: makeTaskList())
    }
}
