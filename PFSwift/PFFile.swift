//
//  PFFile.swift
//  PFSwift
//
//  Created by PFei_He on 15/11/17.
//  Copyright © 2015年 PF-Lib. All rights reserved.
//
//  https://github.com/PFei-He/PFSwift
//
//  vesion: 0.0.7
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
//  ***** 文件操作 *****
//

import Foundation

public class PFFile: NSObject {
    
    /**
     创建文件
     - Note: 文件存放于沙盒中的Documents文件夹中
     - Parameter fileName: 文件名
     - Returns: 无
     */
    public class func createFile(fileName: String) {
        let path = PFFile.path(fileName)
        let manager = NSFileManager.defaultManager()
        if !manager.fileExistsAtPath(path) {//如果文件不存在则创建文件
            manager.createFileAtPath(path, contents:nil, attributes:nil)
        }
    }
    
    /**
     读取文件
     - Note: 文件存放于沙盒中的Documents文件夹中
     - Parameter fileName: 文件名
     - Returns: 文件中的数据
     */
    public class func readFile(fileName: String) -> Dictionary<String, AnyObject> {
        return NSDictionary(contentsOfFile: PFFile.path(fileName)) as! Dictionary<String, AnyObject>
    }
    
    /**
     读取JSON文件
     - Note: 文件存放于main bundle中
     - Parameter fileName: 文件名
     - Returns: 文件中的数据
     */
    public class func readJSON(fileName: String) -> Dictionary<String, AnyObject> {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        let string = try? String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        let data = string?.dataUsingEncoding(NSUTF8StringEncoding)
        return try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! Dictionary<String, AnyObject>
    }
    
    /**
     写入文件
     - Note: 文件存放于沙盒中的Documents文件夹中
     - Parameter fileName: 文件名
     - Parameter params: 写入文件的参数
     - Returns: 写入结果
     */
    public class func writeToFile(fileName: String, params: Dictionary<String, AnyObject>) -> Bool {
        return (params as NSDictionary).writeToFile(PFFile.path(fileName), atomically: true)
    }
    
    ///文件路径
    private class func path(fileName: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = NSURL(fileURLWithPath: paths[0]).URLByAppendingPathComponent(fileName)
        return path.path!
    }
}
