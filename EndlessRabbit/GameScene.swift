// GameScene.swift

import SceneKit
import QuartzCore

class GameScene: SCNScene {
    
    var cameraNode: SCNNode!
    var groundNode: SCNNode!
    var objectNode: SCNNode?
    var runningGirlNode: SCNNode?
    var lanes: [Float] = [-2, 0, 2] // Three lanes
    var currentLaneIndex = 1 // Initial lane index
    
    override init() {
        super.init()
        
        // Set up the scene
        setupCamera()
        setupLight()
        setupGround()
        setupRunningGirl()
        
        print("GameScene initialized")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        cameraNode.eulerAngles = SCNVector3(x: -Float.pi / 12, y: 0, z: 0)
        rootNode.addChildNode(cameraNode)
        print("Camera set up")
    }
    
    func setupLight() {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        rootNode.addChildNode(ambientLightNode)
        
        let directionalLightNode = SCNNode()
        directionalLightNode.light = SCNLight()
        directionalLightNode.light!.type = .directional
        directionalLightNode.light!.color = UIColor(white: 1.0, alpha: 1.0)
        directionalLightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        rootNode.addChildNode(directionalLightNode)
        
        print("Light set up")
    }
    
    func setupGround() {
          groundNode = SCNNode()
          let groundGeometry = SCNFloor()
          groundGeometry.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/grass.png")
          groundNode.geometry = groundGeometry
          
          // Add physics body to the ground
          let groundShape = SCNPhysicsShape(geometry: groundGeometry, options: nil)
          let groundBody = SCNPhysicsBody(type: .static, shape: groundShape)
          groundNode.physicsBody = groundBody
          
          rootNode.addChildNode(groundNode)
          print("Ground set up")
      }
    
    func setupRunningGirl() {
        guard let girlScene = SCNScene(named: "art.scnassets/running.scn") else {
            print("Failed to load running.scn")
            return
        }
        
        runningGirlNode = girlScene.rootNode.childNodes.first!.clone()
        runningGirlNode!.position = SCNVector3(x: lanes[currentLaneIndex], y: 0, z: 0)
        
        // Remove shadow
        runningGirlNode!.enumerateChildNodes { (node, _) in
            node.castsShadow = false
        }
        
        // Add physics body to the running girl
        let shape = SCNPhysicsShape(node: runningGirlNode!, options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox])
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = 1
        runningGirlNode!.physicsBody = physicsBody
        
        // Add running animation
        if let animation = girlScene.rootNode.animationKeys.first {
            let animation = girlScene.rootNode.animation(forKey: animation)!
            runningGirlNode!.addAnimation(animation, forKey: "running")
        }
        
        rootNode.addChildNode(runningGirlNode!)
        print("Running girl set up")
    }
    
    func handleSwipeLeft() {
        if currentLaneIndex > 0 {
            currentLaneIndex -= 1
            moveRunningGirlToLane(index: currentLaneIndex)
        }
    }
    
    func handleSwipeRight() {
        if currentLaneIndex < lanes.count - 1 {
            currentLaneIndex += 1
            moveRunningGirlToLane(index: currentLaneIndex)
        }
    }
    
    func moveRunningGirlToLane(index: Int) {
        let action = SCNAction.moveBy(x: CGFloat(lanes[index] - runningGirlNode!.position.x), y: 0, z: 0, duration: 0.2)
        runningGirlNode!.runAction(action)
    }
    
    func spawnObject() {
        let lane = lanes[Int.random(in: 0..<lanes.count)]
        let objectType = Bool.random() ? "tree" : "carrot"
        
        let objectNode: SCNNode
        
        if objectType == "tree" {
            objectNode = TreeNode()
        } else {
            objectNode = CarrotNode()
        }
        
        objectNode.position = SCNVector3(x: lane, y: 0, z: cameraNode.position.z - 50)
        
        DispatchQueue.main.async {
            self.rootNode.addChildNode(objectNode)
        }
        
        self.objectNode = objectNode
        print("\(objectType.capitalized) spawned")
    }
    
    func updateScene() {
        if let objectNode = objectNode {
            if objectNode.position.z > cameraNode.position.z {
                DispatchQueue.main.async {
                    objectNode.removeFromParentNode()
                }
                spawnObject()
            }
        } else {
            spawnObject()
        }
    }
    
    func moveCamera() {
        let moveCamera = SCNAction.moveBy(x: 0, y: 0, z: -5, duration: 0.5)
        let updateAction = SCNAction.run { _ in self.updateScene() }
        let sequence = SCNAction.sequence([moveCamera, updateAction])
        let repeatAction = SCNAction.repeatForever(sequence)
        cameraNode.runAction(repeatAction)
        print("Camera movement started")
    }
}
