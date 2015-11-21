//
//  PFModel.swift
//  PFSwift
//
//  Created by PFei_He on 15/11/17.
//  Copyright © 2015年 PF-Lib. All rights reserved.
//
//  https://github.com/PFei-He/PFSwift
//
//  vesion: 0.0.8
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
//  ***** 数据模型基类 *****
//

import Foundation

public class PFModel: NSObject, NSXMLParserDelegate {
    
    ///节点
    private var array = NSMutableArray()
    ///节点中的值
    private var string = NSMutableString()

    ///JSON数据
    public var JSON: AnyObject? {
        didSet {
            parseJSON(JSON)
        }
    }
    
    ///XML数据
    public var XML: AnyObject? {
        didSet {
            parseXML(XML)
        }
    }
    
    // MARK: - Life Cycle
    
    /**
     初始化
     - Note: 无
     - Parameter JSON: JSON数据
     - Returns: Model实例
     */
    public convenience init(JSON: AnyObject?) {
        self.init()
        self.JSON = JSON
    }
    
    /**
     初始化
     - Note: 无
     - Parameter XML: XML数据
     - Returns: Model实例
     */
    public convenience init(XML: AnyObject?) {
        self.init()
        self.XML = XML
    }
    
    // MARK: - Private Methods
    
    ///解析JSON
    private func parseJSON(var JSON: AnyObject?) {
        if JSON != nil {
            //判断数据类型
            if JSON is Dictionary<String, AnyObject> == false && JSON is NSData == false {
                print("The JSON object must be type of dictionary or data")
                return;
            } else if JSON is NSData {
                JSON = try? NSJSONSerialization.JSONObjectWithData(JSON as! NSData, options: .AllowFragments)
            }
            //将键值设置为属性（解析JSON）
            setValuesForKeysWithDictionary(JSON as! Dictionary<String, AnyObject>)
        }
    }
    
    ///解析XML
    private func parseXML(var XML: AnyObject?) {
        if XML != nil {
            //节点
            array.addObject(NSMutableDictionary())
            
            //判断数据类型
            if XML is String == false && XML is NSData == false {
                NSLog("The XML object must be type of string or data");
                return;
            } else if XML is String {
                XML = XML!.dataUsingEncoding(NSUTF8StringEncoding)
            }
            
            //XML解析器
            let parser = NSXMLParser(data: XML as! NSData)
            parser.delegate = self
            if parser.parse() {//解析XML
                self.JSON = array[0]
            } else {
                print("XML data can't be parse");
            }
        }
    }
    
    //获取未被声明的对象
    public override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("**Class->"+String(classForCoder), "UndefinedKey->"+key, "Type->"+String(value?.classForCoder), "Value->"+String(value)+"**")
    }

    // MARK: - NSXMLParserDelegate Methods
    
    //读取节点头
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //父节点
        let parentDict = array.lastObject as! NSMutableDictionary
        
        //子节点
        let childDict = NSMutableDictionary()
        childDict.addEntriesFromDictionary(attributeDict)
        
        let value = parentDict[elementName]
        
        if value != nil {
            var array: NSMutableArray
            if value is NSMutableArray {
                array = value as! NSMutableArray
            } else {
                array = NSMutableArray()
                array.addObject(value!)
                parentDict.setValue(array, forKey: elementName)
            }
            array.addObject(childDict)
        } else {
            parentDict.setObject(childDict, forKey: elementName)
        }
        self.array.addObject(childDict)
    }
    
    //读取节点尾
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let dictionary = self.array.lastObject as! NSMutableDictionary
        
        if self.string.length > 0 {//剪切字符串，去掉空白和换行
            let string = self.string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            dictionary.setObject(string, forKey: elementName)
            self.string = NSMutableString.init()
        }
        self.array.removeLastObject()
    }
    
    //读取节点中的值
    public func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.string.appendString(string)
    }
}
