//
//  SampleDataGenerator.swift
//  MSLoadMore
//
//  Created by Mohamad Sheikh on 9/16/17.
//  Copyright © 2017 Mohamad Sheikh. All rights reserved.
//

import UIKit

class SampleDataGenerator: NSObject {
    
    var title : String!
    var number : Int!
    
    class func generateData(count:Int = 1,offset:Int = 0) -> [SampleDataGenerator] {
        var data : [SampleDataGenerator] = []
        
        let finalIndex = count + offset
        
        for index in offset..<finalIndex {
            let item = SampleDataGenerator()
            item.number = index
            item.title = "hello\(index)"
            data.append(item)
        }
      return data
    }
}
