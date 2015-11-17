//
//  RootModel.swift
//  Demo
//
//  Created by PFei_He on 15/11/13.
//  Copyright © 2015年 PF-Lib. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

class Sports: PFModel {
    
    var one     = String()
    var two     = String()
}

class Fruits: PFModel {
    
    var fruit   = String()
}

class Food: PFModel {
    
    var meat    = String()
    var fruit   = Array<AnyObject>()
}

class Person: PFModel {
    
    var name    = String()
    var age     = Int()
    var sex     = String()
    var phone   = Int()
    var address = Array<AnyObject>()
    var height  = Int()
    var weight  = Int()
    var food    = Dictionary<String, AnyObject>()
    var sport   = Array<AnyObject>()
    var code    = String()
    
    /**
     单例
     - Note:
     - Parameter 无
     - Returns: Person的唯一实例
     */
    class func sharedInstance() -> Person {
        struct sharedInstance {
            static var onceToken: dispatch_once_t = 0
            static var instance: Person? = nil
        }
        dispatch_once(&sharedInstance.onceToken) { () -> Void in
            sharedInstance.instance = Person()
        }
        return sharedInstance.instance!
    }
}
