//
//  ViewController.swift
//  ASTextNodeTest
//
//  Created by Jason Yu on 1/4/16.
//  Copyright © 2016 Ruguo. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: UIViewController {
    let tableView = ASTableView()
    var rowCount = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(tableView)
        tableView.frame = self.view.bounds
        
        tableView.asyncDataSource = self
    }
}

extension ViewController: ASTableDataSource {
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        return TestContainerNode()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
}

class TestContainerNode: ASCellNode {
    var subnode = TestSubnode()
    override init() {
        super.init()
        self.addSubnode(subnode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15), child: subnode)
        return insetSpec
    }
}

class TestSubnode: ASDisplayNode {
    let topicTextNode: ASTextNode
    
    override init() {
        topicTextNode = ASTextNode()
        topicTextNode.backgroundColor = UIColor.lightGrayColor()
        let paragraphStyle = NSMutableParagraphStyle()
        let font = UIFont.boldSystemFontOfSize(26)
        // When disabling the hypenationFactor, this issue goes away
        paragraphStyle.hyphenationFactor = 0.5
        let topicAttr: [String: AnyObject] = [NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName:font]
        topicTextNode.attributedString = NSAttributedString(string: "This should not 'Nederlandse bombardementen' cut off", attributes: topicAttr)
        
        super.init()

        self.addSubnode(topicTextNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topicStack = ASStackLayoutSpec(direction: .Vertical, spacing: 10, justifyContent: .Center, alignItems: .Center, children: [topicTextNode])
        return topicStack
    }
}