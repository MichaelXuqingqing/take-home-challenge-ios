//
//  MSFightCampViewController.swift
//  FightCamp-Homework
//
//  Created by Michael Xu on 2022/8/18.
//  Copyright © 2022 Alexandre Marcotte. All rights reserved.
//

import UIKit

class MSFightCampViewController: MSBaseViewController {
    //Use viewModel to coordinate the Model and View
    lazy var viewModel: MSFightCampViewModel = {
        let viewModel = MSFightCampViewModel()
        return viewModel
    }()
    
    //Use tableView to display multiple packages. Make page layouts reusable
    let mainTableView = UITableView(frame: .zero, style: .plain)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configMainView()
    }
    
    func configMainView() {
        mainTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mainTableView.backgroundColor = UIColor.secondaryBackground
        mainTableView.alwaysBounceVertical = true
        mainTableView.separatorStyle = .none
        mainTableView.dataSource = self
        mainTableView.delegate = self
        view.addSubview(self.mainTableView)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: mainTableView.frame.width, height: CGFloat.packageSpacing))
        headerView.backgroundColor = mainTableView.backgroundColor
        mainTableView.tableHeaderView = headerView
        
        mainTableView.register(MSFightCampTableViewCell.self, forCellReuseIdentifier: MSFightCampTableViewCell.identifier)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension MSFightCampViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //The height of the cell is automatically calculated based on the content
        return MSFightCampTableViewCell.getCellHeight(indexPath: indexPath, viewModel: viewModel)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MSFightCampTableViewCell.identifier,for:indexPath) as! MSFightCampTableViewCell
        cell.selectionStyle = .none
        //Bind the viewModel to each cell
        cell.bindViewModel(viewModel)
        //Set the custom property of each cell to mark the indexPath of the cell
        cell.indexPath = indexPath
        //Update the content displayed on the cell
        cell.updateContent()
        return cell
    }
}
