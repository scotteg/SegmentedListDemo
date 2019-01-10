//
//  ViewController.swift
//  SegmentedListDemo
//
//  Created by Scott Gardner on 1/10/19.
//  Copyright © 2019 Scott Gardner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var noSelectedItemsLabel: UILabel!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectionChanged(_ sender: Any) {
        tableView.reloadData()
        updateNoSelectedItemsLabel()
    }
    
    func updateNoSelectedItemsLabel() {
        if segmentedControl.selectedSegmentIndex == 0 {
            noSelectedItemsLabel.isHidden = viewModel.selectedData.count != 0
        } else {
            noSelectedItemsLabel.isHidden = viewModel.data.count != 0
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? viewModel.selectedData.count : viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = indexPath.row
        let item = segmentedControl.selectedSegmentIndex == 0 ? viewModel.selectedData[row] : viewModel.data[row]
        cell.textLabel?.text = item.value
        cell.accessoryType = item.isSelected ? .checkmark : .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = cell.accessoryType == .checkmark ? .none : .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let item = segmentedControl.selectedSegmentIndex == 0 ? viewModel.selectedData[row] : viewModel.data[row]
        item.isSelected.toggle()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.performBatchUpdates({ tableView.deleteRows(at: [indexPath], with: .automatic) }, completion: { [weak self] _ in self?.updateNoSelectedItemsLabel() })
        }
    }
}
