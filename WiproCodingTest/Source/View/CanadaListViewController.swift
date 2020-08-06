//
//  CanadaListViewController.swift
//  WiproCodingTest
//
//  Created by Shankar lakkimsetti on 22/07/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class CanadaListViewController: UITableViewController {
    lazy var canadaInfoList: [Rows?]? = {
        return [Rows?]()
    }()
    lazy var canadaViewModel: CanadaViewModel? = {
        return CanadaViewModel()
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupCanadaListTableView()
        self.loadCanadaData()
    }
    
    // MARK: - Set up Navigation bar
    func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: AppFonts.helveticaNeueMedium, size: (UIDevice.current.userInterfaceIdiom == .pad) ? 30 : 18)!,.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = AppColors.themeColor
        self.title = AppConstants.canadaNavigationTitle
    }
    
    // MARK: - Set up UITableView
    func setupCanadaListTableView() {
        let refreshControl = UIRefreshControl()
        tableView.register(CanadaListCell.self, forCellReuseIdentifier: AppConstants.cellIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = AppColors.themeColor
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
    }
    
    // MARK: - Load Canada Data
    fileprivate func loadCanadaData() {
        canadaViewModel?.fetchCanadaData()
        canadaViewModel?.reloadDataCompletionBlock = { [weak self] in
            if let rowsArray = self?.canadaViewModel?.canadaData?.rows {
                self?.canadaInfoList = rowsArray.map { $0 }
            }
            DispatchQueue.main.async {
                self?.title = (self?.canadaViewModel?.canadaData?.title != nil) ? self?.canadaViewModel?.canadaData?.title : AppConstants.canadaNavigationTitle
                guard let _ = self?.canadaInfoList?.count else {
                    self?.setNoDataAvailable()
                    return
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Set No Data Available
    func setNoDataAvailable() {
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.text = AppConstants.noDataAvailable
        emptyLabel.textColor = AppColors.themeColor
        emptyLabel.font = UIFont(name: AppFonts.helveticaNeueMedium, size: (UIDevice.current.userInterfaceIdiom == .pad) ? 30 : 18)!
        emptyLabel.textAlignment = NSTextAlignment.center
        tableView.backgroundView = emptyLabel
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    // MARK: - UITableView Delegate And Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.canadaInfoList?.count else {
            return 0
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.cellIdentifier, for: indexPath) as! CanadaListCell
        let canadaViewModel = self.canadaInfoList?[indexPath.row]
        cell.canadaEachRowData = canadaViewModel
        return cell
    }
    
    // MARK: - Refresh Table Data
    @objc func refreshTableData(sender: UIRefreshControl) {
        self.loadCanadaData()
        sender.endRefreshing()
    }
    
}
