//
//  CarrotNode.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//

import SceneKit

class CarrotNode: SCNNode {
    
    override init() {
        super.init()
        
        if let carrotScene = SCNScene(named: "art.scnassets/carrot.scn") {
            for childNode in carrotScene.rootNode.childNodes {
                // Remove shadow
                childNode.castsShadow = false
                addChildNode(childNode)
            }
            print("CarrotNode initialized from carrot.scn")
        } else {
            print("Failed to load carrot.scn")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
