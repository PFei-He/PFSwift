//
//  PFFile.swift
//  PFSwift
//
//  Created by PFei_He on 15/11/17.
//  Copyright © 2015年 PF-Lib. All rights reserved.
//
//  https://github.com/PFei-He/PFSwift
//
//  vesion: 0.1.4
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
        let path = readFile(fileName, directory: "document", type: nil) as! String
        let manager = NSFileManager.defaultManager()
        if !manager.fileExistsAtPath(path) {//如果文件不存在则创建文件
            manager.createFileAtPath(path, contents:nil, attributes:nil)
            writeToFile(fileName, params: ["": ""])
        }
    }
    
    /**
     读取Dictionary类型文件
     - Note: 文件存放于沙盒中的Documents文件夹中
     - Parameter fileName: 文件名
     - Returns: 文件中的数据
     */
    public class func readDictionary(fileName: String) -> Dictionary<String, AnyObject> {
        return NSDictionary(contentsOfFile: readFile(fileName, directory: "document", type: nil) as! String) as! Dictionary<String, AnyObject>
    }
    
    /**
     读取String类型文件
     - Note: 文件存放于沙盒中的Documents文件夹中
     - Parameter fileName: 文件名
     - Returns: 文件中的数据
     */
    public class func readString(fileName: String) -> String {
        return try! String(contentsOfFile: readFile(fileName, directory: "document", type: nil) as! String, encoding: NSUTF8StringEncoding)
    }
    
    /**
     读取JSON类型文件
     - Note: 文件存放于main bundle中
     - Parameter fileName: 文件名
     - Returns: 文件中的数据
     */
    public class func readJSON(fileName: String) -> NSData {
        return readFile(fileName, directory: "bundle", type: "json") as! NSData
    }
    
    /**
     读取XML类型文件
     - Note: 文件存放于main bundle中
     - Parameter fileName: 文件名
     - Returns: 文件中的数据
     */
    public class func readXML(fileName: String) -> NSData {
        return readFile(fileName, directory: "bundle", type: "xml") as! NSData
    }
    
    /**
     写入文件
     - Note: 文件存放于沙盒中的Documents文件夹中
     - Parameter fileName: 文件名
     - Parameter params: 写入文件的参数
     - Returns: 写入结果
     */
    public class func writeToFile(fileName: String, params: Dictionary<String, AnyObject>) -> Bool {
        return (params as NSDictionary).writeToFile(PFFile.readFile(fileName, directory: "document", type: nil) as! String, atomically: true)
    }
    
    /**
     往文件中添加参数
     - Note: 文件存放于沙盒中的Documents文件夹中
     - Parameter fileName: 文件名
     - Parameter params: 写入文件的参数
     - Returns: 写入结果
     */
    public class func file(fileName: String, setParams params: Dictionary<String, AnyObject>) -> Bool {
        var dictionary = readDictionary(fileName)
        dictionary.removeValueForKey("")
        dictionary.addEntries(params)
        return PFFile.writeToFile(fileName, params: dictionary)
    }
    
    ///读取资源包文件或沙盒文件
    private class func readFile(fileName: String, directory: String, type: String?) -> AnyObject {
        if directory == "bundle" {//资源包文件
            let path = NSBundle.mainBundle().pathForResource(fileName, ofType: type)
            let string = try? String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            return string!.dataUsingEncoding(NSUTF8StringEncoding)!
        } else {//沙盒文件
            let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let path = NSURL(fileURLWithPath: paths[0]).URLByAppendingPathComponent(fileName)
            return path.path!
        }
    }
}
