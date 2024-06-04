//
//  TreeNode.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.


import SceneKit

class TreeNode: SCNNode {
    
    override init() {
        super.init()
        
        if let treeScene = SCNScene(named: "art.scnassets/Tree.scn") {
            for childNode in treeScene.rootNode.childNodes {
                // Remove shadow
                childNode.castsShadow = false
                addChildNode(childNode)
            }
            print("TreeNode initialized from Tree.scn")
        } else {
            print("Failed to load tree.scn")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
