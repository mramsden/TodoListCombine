//
//  TaskListViewController.swift
//  TodoList
//
//  Created by Marcus Ramsden on 28/08/2019.
//  Copyright © 2019 Marcus Ramsden. All rights reserved.
//

import class Combine.AnyCancellable
import UIKit

class TaskListViewController: UITableViewController {

    var viewModel: TaskListViewModel?
    private let taskListDataSource = TaskListTableViewDataSource()
    private var fetchTasksSubscription: AnyCancellable?

    init() {
        super.init(style: .plain)
        title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        fetchTasksSubscription?.cancel()
        fetchTasksSubscription = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = taskListDataSource
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        fetchTasksSubscription = viewModel?.fetchTasks().sink { [weak self] tasks in
            self?.taskListDataSource.tasks = tasks
            self?.tableView.reloadData()
        }
    }

    @objc private func addTask() {
        viewModel?.addTask()
    }
}

class TaskListTableViewDataSource: NSObject, UITableViewDataSource {

    var tasks = [Task]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if tasks.indices.contains(indexPath.row) {
            cell.textLabel?.text = tasks[indexPath.row].summary
        }
        return cell
    }
}
