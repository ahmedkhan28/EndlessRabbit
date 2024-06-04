//
//  CarrotNode.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//

//
//  CarrotNode.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//

import SceneKit

class CarrotNode: SCNNode {
    static var bitMask: Int = 0
    
    override init() {
        super.init()
        
        if let carrotScene = SCNScene(named: "art.scnassets/carrot.scn") {
            for childNode in carrotScene.rootNode.childNodes {
                // Remove shadow
                childNode.castsShadow = false
                addChildNode(childNode)
            }
            
            // Add physics body to the carrot
            let shape = SCNPhysicsShape(node: self, options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox])
            physicsBody = SCNPhysicsBody(type: .static, shape: shape)
            physicsBody?.categoryBitMask = CarrotNode.bitMask
            
            print("CarrotNode initialized from carrot.scn")
        } else {
            print("Failed to load carrot.scn")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
