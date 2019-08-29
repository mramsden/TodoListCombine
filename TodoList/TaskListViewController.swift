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
    private var diffableTasksDataSource: TaskListDiffableDataSource?
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        diffableTasksDataSource = TaskListDiffableDataSource(tableView: tableView) { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = task.summary
            return cell
        }
        
        fetchTasksSubscription = viewModel?.fetchTasks.sink { [weak self] tasks in
            self?.diffableTasksDataSource?.apply(items: tasks)
        }
    }

    @objc private func addTask() {
        viewModel?.addTask()
    }
}

class TaskListDiffableDataSource: NSObject, UITableViewDataSource {

    private let tableView: UITableView
    private let cellProvider: (UITableView, IndexPath, Task) -> UITableViewCell
    private var items = [Task]()
    
    init(tableView: UITableView, cellProvider: @escaping (UITableView, IndexPath, Task) -> UITableViewCell) {
        self.tableView = tableView
        self.cellProvider = cellProvider
        super.init()
        tableView.dataSource = self
    }
    
    func apply(items: [Task]) {
        self.items = items
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellProvider(tableView, indexPath, items[indexPath.row])
    }
}
