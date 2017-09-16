//
//  ViewController.swift
//  MSLoadMore
//
//  Created by Mohamad Sheikh on 9/16/17.
//  Copyright © 2017 Mohamad Sheikh. All rights reserved.
//
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isLoadMore : Bool = false
    var dataArray : [SampleDataGenerator] = []
    
    var currentOffset = 0
    
    let itemsToLoadEachTime = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "LoadMoreFooter", bundle: Bundle.main)
        
        self.tableView .register(nib, forCellReuseIdentifier: "LoadMoreCell")
        
        self.dataArray = fetchData(count: itemsToLoadEachTime, offset: 0)
    }
    func fetchData(count:Int = 0,offset:Int = 0) -> [SampleDataGenerator] {
        let data = SampleDataGenerator.generateData(count: count, offset: offset)
        currentOffset = offset + count
        return data
    }
    // example of pushing objects to data model, can come from server.
    func loadMoreData() {
        // we make sure if table is already loading more data.
        if isLoadMore {
            
            // we fetch data (aka from a server or database).
            let newData = self.fetchData(count: itemsToLoadEachTime, offset: currentOffset)
            self.dataArray.append(contentsOf: newData)
            
            // configure UITableView UI.
            isLoadMore = false;
            self.tableView.tableFooterView = nil;
            
            let offset = self.tableView.contentOffset;
            self.tableView.contentOffset = offset
            
            // reload UITableView according to new data.
            self.tableView.reloadData()
        }
    }
    // MARK: - UITableViewDelegate And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = dataArray[indexPath.row].title
        return cell!;
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore == false {
            // we first check if we need to load more items.
            if doesRequireReloadForIndexPathInDataArray(indexPath: indexPath, dataArray: dataArray) {
                // configuring UItableView to show load more cell.
                let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell")
                tableView.tableFooterView = loadMoreCell
                isLoadMore = true
                
                // added a delay to be able to see load more cell. (can be removed)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    // requesting for more data.
                    self.loadMoreData()
                })
            }
        }
    }
    func doesRequireReloadForIndexPathInDataArray(indexPath:IndexPath,dataArray:Array<Any>) -> Bool {
        if indexPath.row + 1 >= dataArray.count {
            return true
        }
        return false
    }
    
}
