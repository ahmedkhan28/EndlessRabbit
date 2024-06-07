//
//  TreeNode.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.


//  TreeNode.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//

import SceneKit

class TreeNode: SCNNode {
    static var bitMask: Int = 0
    
    override init() {
        super.init()
        
        if let treeScene = SCNScene(named: "art.scnassets/Tree.scn") {
            for childNode in treeScene.rootNode.childNodes {
                // Remove shadow
                childNode.castsShadow = false
                addChildNode(childNode)
            }
            
            // Add physics body to the tree
            let shape = SCNPhysicsShape(node: self, options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox])
            physicsBody = SCNPhysicsBody(type: .static, shape: shape)
            physicsBody?.categoryBitMask = TreeNode.bitMask
            
            print("TreeNode initialized from Tree.scn")
        } else {
            print("Failed to load tree.scn")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
