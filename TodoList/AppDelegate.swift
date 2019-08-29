//
//  AppDelegate.swift
//  TodoList
//
//  Created by Marcus Ramsden on 28/08/2019.
//  Copyright © 2019 Marcus Ramsden. All rights reserved.
//

import UIKit

let viewControllerFactory = ViewControllerFactory(taskList: {
    let list = TaskList()
    (1...10).map { Task(summary: "Task \($0)") }.forEach(list.add(task:))
    return list
}())

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

}

