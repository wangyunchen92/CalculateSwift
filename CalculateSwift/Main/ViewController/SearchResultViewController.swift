//
//  SearchResultViewController.swift
//  Browser
//
//  Created by 王云晨 on 2019/5/14.
//  Copyright © 2019 Sj03. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class SearchResultViewController: UIViewController,UISearchBarDelegate,UIViewControllerTransitioningDelegate ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var searchBar: UISearchBar!
    var tableView:UITableView?
    var viewModel = SearchResultViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView.init(frame: CGRect(x: 0, y: 88, width: kScreenWidth, height: kScreenHeight-40))
        self.view.addSubview(self.tableView!)
        self.viewModel.block_getData = ({
            DispatchQueue.main.async {
                self.tableView!.reloadData()
            }
        })

        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView!.estimatedSectionHeaderHeight = 0;
        self.tableView!.estimatedSectionFooterHeight = 0;
        self.tableView?.tableFooterView = UIView.init(frame: CGRect.zero)
        self.tableView?.tableHeaderView = UIView.init(frame: CGRect.zero)
        
        
        self.searchBar.placeholder = "搜索或者输入网址"
        
        self.searchBar.searchBarStyle = .minimal
        
        self.searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        
        self.searchBar.setImage(UIImage.init(named: "cheez_search_icn.imageset"), for: UISearchBar.Icon.search, state: UIControl.State.normal)
        
        self.searchBar.sizeToFit()
        
        let searchField:UITextField = self.searchBar.value(forKey: "_searchField") as! UITextField
        searchField.backgroundColor = .clear
        
        self.searchBar.delegate = self
        
        
         searchBar.setShowsCancelButton(true, animated: true)
        
        for view in searchBar.subviews[0].subviews {
            if view is UIButton {
                let button = view as! UIButton
                button.setTitle("取消", for: UIControl.State.normal)
            }
        }
        searchField.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.subject_getData.input.send(value: searchText)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.textLabel?.text = self.viewModel.dataArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defalut = UserDefaults.standard
        var userHistoryRead = defalut.array(forKey: UserModel().historyRead)
        if  userHistoryRead == nil {
            userHistoryRead = [String]()
        }

        if !(userHistoryRead?.contains(where: { (str) -> Bool in
            return  str as! String  == self.viewModel.dataArray[indexPath.row]
        }) ?? true) {
            userHistoryRead?.append(self.viewModel.dataArray[indexPath.row])
        }
        defalut.set(userHistoryRead, forKey: UserModel().historyRead)


    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Pass the selected object to the new view controller.
    }
    */

}
