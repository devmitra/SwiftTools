//
//  XmlToMap.swift
//  PackageManagerLib
//
//  Created by Pushan Mitra on 21/04/17.
//
//

import Foundation

internal var RootTag: String = "root"

public var kXMLTagValue = "value"
public var kXMLAttributes = "attributes"

public typealias JSON = [String : Any]


public class XMLTag: CustomStringConvertible  {
    public var tagName: String?
    var children: [XMLTag] = [XMLTag]()
    public var attributes: [String : String]?
    var value: Any?
    var level: Int = -1
    
    
    init() {}
    
    init(_ tag: XMLTag) {
        self.tagName = tag.tagName
        self.attributes = tag.attributes
        self.children = tag.children
        self.value = tag.value
        self.level = tag.level
    }
    
    public var JSON : JSON? {
    
        
        var innerJson: JSON = [String : Any]()
        if let attr = self.attributes, attr.count > 0 {
            innerJson[kXMLTagValue] = self.value
            innerJson[kXMLAttributes] = self.attributes
        }
        if self.children.count > 0 {
            for tag in self.children {
                if let tagnm: String = tag.tagName {
                    var tagValue: Any;
                    
                    if let tgJSON = tag.JSON {
                        tagValue = tgJSON
                    }
                    else if let val = tag.value {
                        tagValue = val
                    }
                    else {
                        tagValue = ""
                    }
                    
                    if var list: [Any] = innerJson[tagnm] as? [Any] {
                        list.append(tagValue)
                        innerJson[tagnm] = list
                    }
                    else if let val = innerJson[tagnm]  {
                        var list: [Any] = [Any]()
                        list.append(val)
                        list.append(tagValue)
                        innerJson[tagnm] = list
                    }
                    else {
                        innerJson[tagnm] = tagValue
                    }
                }
            }
            
            if self.value != nil {
                innerJson[kXMLTagValue] = self.value
            }
        }
        
        
        if innerJson.count == 0 {
            return nil
        }
        
        return innerJson
    }
    
    public var description: String {
        
        var tab: String = ""
        if self.level >= 0 {
            for _ in 0...self.level {
                tab.append("\t")
            }
        }
        
        var str: String = "\n\(tab)<\(tagName!)>"
        
        if let val = self.value {
            str.append("\(val)")
        }
        
        for tag in children {
            str.append("\(tag)")
        }
        
        if self.children.count > 0 {
            str.append("\n\(tab)</\(tagName!)>")
        }
        else {
            str.append("</\(tagName!)>")
        }
        
        return str
    }
    
    public subscript (tag: String) -> [XMLTag] {
        var childtags: [XMLTag] = [XMLTag]()
        
        for child in children {
            if let tgName = child.tagName, tgName == tag {
                childtags.append(child)
            }
        }
        
        return childtags
    }
}

public class XMLMap :NSObject {
    
    internal var xmlParser: XMLParser?
    internal var stack: [XMLTag] = [XMLTag]()
    internal var root: XMLTag?
    
    
    
    public func parse(contentOfUrl url: URL) -> Void {
        
        self.xmlParser = XMLParser(contentsOf: url as URL)
        self.parseInternal()
    }
    
    public func parse(xmlData data: Data) -> Void {
        
        self.xmlParser = XMLParser(data: data);
        self.parseInternal()
        
    }
    
    internal func parseInternal() {
        self.xmlParser?.delegate = self
        self.xmlParser?.parse();
        
    }
    
    internal func clean() {
        self.xmlParser?.delegate = nil
        self.xmlParser = nil
        self.root = self.stack.last
        self.stack.removeAll()
    }
    
    override public var description: String {
        guard let des = self.root?.description else {
            return ""
        }
        return des;
    }
    
    public subscript(tagName: String) -> [XMLTag] {
        
        guard let val: [XMLTag] = self.root?[tagName] else {
            return []
        }
        
        return val
    }
    
    public var JSON: JSON? {
        return self.root?.JSON
    }
    
    public func display() {
        
        if let des: String = self.root?.description {
            print("XML-MAP: ==============================\(des)")
            print("======================================== ")
        }
        else {
            print("XML-MAP: Empty")
        }
    }
    
}

extension XMLMap: XMLParserDelegate {
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        
        let rootTag: XMLTag = XMLTag()
        rootTag.tagName = RootTag
        rootTag.level = -1;
        self.stack.append(rootTag)
        
        //print("Start");
        
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        
        /*if let last = self.stack.popLast(), last != RootTag {
            print("Problem: Last Element is not root :");
            print("\(self.stack)")
        }*/
        
        self.root = self.stack.last
        
        self.clean()
        
        //print("End");
    }
    
    public func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        //print("\(#function): \(name) \(publicID) \(systemID)")
        
    }
    
    public func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {
        //print("\(#function): \(name) \(publicID) \(systemID)")
    }
    
    public func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        //print("\(#function): \(attributeName) \(elementName) \(type) \(defaultValue)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        //print("\(#function): \(elementName) \(model)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        //print("\(#function): \(name) \(value)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        //print("\(#function): \(name) \(publicID) \(systemID)")
        
    }
    
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        //print("\(#function): \(elementName) \(namespaceURI) \(qName)")
        
        let newTag: XMLTag = XMLTag()
        newTag.tagName = elementName;
        newTag.attributes = attributeDict
        newTag.level = self.stack.count - 1
        
        if let top: XMLTag = self.stack.last {
            top.children.append(newTag);
        }
        self.stack.append(newTag);
    }
    
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("\(#function): \(elementName) \(namespaceURI) \(qName)")
        
        guard let tag: XMLTag = self.stack.popLast(), let tagName: String = tag.tagName, tagName == elementName else {
            print("\(#function): Tag Mismatch with stack Tracke: \(elementName)")
            return
        }
        
    }
    
    
    public func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        //print("\(#function): \(prefix) \(namespaceURI)")
        
    }
    
    
    public func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
        //print("\(#function): \(prefix)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print("\(#function): \(string)")
        if let tag: XMLTag = self.stack.last, !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            tag.value = string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
    }
    
    
    public func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String)  {
        //print("\(#function): \(whitespaceString)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
        //print("\(#function): \(target)   \(data)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundComment comment: String) {
        //print("\(#function): \(comment)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        //print("\(#function):")
        
        if let tag: XMLTag = self.stack.last, CDATABlock.count > 0 {
            tag.value = CDATABlock
        }
        
    }
    
    
    public func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data? {
        //print("\(#function): \(name) \(systemID)")
        return nil;
    }
    
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("\(#function): \(parseError)")
        
    }
    
    
    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("\(#function): \(validationError)")
    }
    
}
