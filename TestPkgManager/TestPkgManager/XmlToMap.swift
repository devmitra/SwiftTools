//
//  XmlToMap.swift
//  PackageManagerLib
//
//  Created by Pushan Mitra on 21/04/17.
//
//

import Foundation

internal var RootTag: String = "root"


internal struct XMLTag  {
    var tageName: String?
    var children: [XMLTag] = [XMLTag]()
    var attributes: [String : String]?
    var value: Any?
    
    
    init() {
        
    }
    
    init(_ tag: XMLTag) {
        self.tageName = tag.tageName
        self.attributes = tag.attributes
        self.children = tag.children
        self.value = tag.value
    }
}

public class XMLToMap :NSObject {
    
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
        self.stack.removeAll()
    }
    
    public func display() {
        print("XML MAP: \(self.root)")
    }
    
}

extension XMLToMap: XMLParserDelegate {
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        
        var rootTag: XMLTag = XMLTag()
        rootTag.tageName = RootTag
        self.stack.append(rootTag)
        
        print("Start");
        
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        
        /*if let last = self.stack.popLast(), last != RootTag {
            print("Problem: Last Element is not root :");
            print("\(self.stack)")
        }*/
        
        self.root = self.stack.last
        
        self.clean()
        
        print("End");
    }
    
    public func parser(_ parser: XMLParser, foundNotationDeclarationWithName name: String, publicID: String?, systemID: String?) {
        print("\(#function): \(name) \(publicID) \(systemID)")
        
    }
    
    public func parser(_ parser: XMLParser, foundUnparsedEntityDeclarationWithName name: String, publicID: String?, systemID: String?, notationName: String?) {
        print("\(#function): \(name) \(publicID) \(systemID)")
    }
    
    public func parser(_ parser: XMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        print("\(#function): \(attributeName) \(elementName) \(type) \(defaultValue)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundElementDeclarationWithName elementName: String, model: String) {
        print("\(#function): \(elementName) \(model)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundInternalEntityDeclarationWithName name: String, value: String?) {
        print("\(#function): \(name) \(value)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundExternalEntityDeclarationWithName name: String, publicID: String?, systemID: String?) {
        print("\(#function): \(name) \(publicID) \(systemID)")
        
    }
    
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("\(#function): \(elementName) \(namespaceURI) \(qName)")
        var newTag: XMLTag = XMLTag()
        newTag.tageName = elementName;
        newTag.attributes = attributeDict
        self.stack.append(newTag);
    }
    
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("\(#function): \(elementName) \(namespaceURI) \(qName)")
        
        if let tag: XMLTag = self.stack.popLast(), let tagName: String = tag.tageName, tagName == elementName {
            
        }
        
        
    }
    
    
    public func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        print("\(#function): \(prefix) \(namespaceURI)")
        
    }
    
    
    public func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
        print("\(#function): \(prefix)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("\(#function): \(string)")
        
        if var tag: XMLTag = self.stack.last, string != "" {
            tag.value = string
        }
        
    }
    
    
    public func parser(_ parser: XMLParser, foundIgnorableWhitespace whitespaceString: String)  {
        print("\(#function): \(whitespaceString)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundProcessingInstructionWithTarget target: String, data: String?) {
        print("\(#function): \(target)   \(data)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundComment comment: String) {
        print("\(#function): \(comment)")
        
    }
    
    
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        print("\(#function):")
        
        if var tag: XMLTag = self.stack.last, CDATABlock.count > 0 {
            tag.value = CDATABlock
        }
        
    }
    
    
    public func parser(_ parser: XMLParser, resolveExternalEntityName name: String, systemID: String?) -> Data? {
        print("\(#function): \(name) \(systemID)")
        return nil;
    }
    
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("\(#function):")
        
    }
    
    
    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("\(#function):")
    }
    
}
