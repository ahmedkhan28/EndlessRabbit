
import SceneKit
import QuartzCore

class GameScene: SCNScene, SCNPhysicsContactDelegate {
    
    var cameraNode: SCNNode!
    var groundNode: SCNNode!
    var objectNode: SCNNode?
    var bunnyNode: SCNNode?
    var lanes: [Float] = [-2, 0, 2] // Three lanes
    var currentLaneIndex = 1 // Initial lane index
    
    override init() {
        super.init()
        
        // Set up the scene
        setupCamera()
        setupLight()
        setupGround()
        setupBunny()
        setupCollisions()
        
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
       
        // Set reflectivity to zero
        groundGeometry.reflectivity = 0.0
        
        groundNode.geometry = groundGeometry
        groundNode.position = SCNVector3(x: 0, y: -0.1, z: 0)
        
        // Add physics body to the ground
        let groundShape = SCNPhysicsShape(geometry: groundGeometry, options: nil)
        let groundBody = SCNPhysicsBody(type: .static, shape: groundShape)
        groundNode.physicsBody = groundBody
        
        rootNode.addChildNode(groundNode)
        print("Ground set up")
    }
    
    func setupBunny() {
        guard let bunnyScene = SCNScene(named: "art.scnassets/rabbit.scn") else {
            print("Failed to load rabbit.scn")
            return
        }
        
        bunnyNode = bunnyScene.rootNode.childNodes.first!.clone()
        bunnyNode!.position = SCNVector3(x: lanes[currentLaneIndex], y: 0, z: 0)
        
        // Remove shadow
        bunnyNode!.enumerateChildNodes { (node, _) in
            node.castsShadow = false
        }
        
        // Add physics body to the bunny
        let shape = SCNPhysicsShape(node: bunnyNode!, options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.boundingBox])
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        physicsBody.isAffectedByGravity = false
        physicsBody.categoryBitMask = 1
        physicsBody.contactTestBitMask = 2 | 4 // Detect collisions with carrots (2) and trees (4)
        bunnyNode!.physicsBody = physicsBody
        
        rootNode.addChildNode(bunnyNode!)
        print("Bunny set up")
    }
    
    func setupCollisions() {
        // Set up collision bit masks
        CarrotNode.bitMask = 2
        TreeNode.bitMask = 4
        
        // Set physics contact delegate
        physicsWorld.contactDelegate = self
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        
        if nodeA.physicsBody?.categoryBitMask == CarrotNode.bitMask || nodeB.physicsBody?.categoryBitMask == CarrotNode.bitMask {
            // Bunny collided with a carrot
            let carrotNode = (nodeA.physicsBody?.categoryBitMask == CarrotNode.bitMask) ? nodeA : nodeB
            carrotNode.removeFromParentNode()
            playChimpupSound()
        } else if nodeA.physicsBody?.categoryBitMask == TreeNode.bitMask || nodeB.physicsBody?.categoryBitMask == TreeNode.bitMask {
            // Bunny collided with a tree
            gameOver()
        }
    }
    
    func playChimpupSound() {
        guard let chimpupSound = SCNAudioSource(fileNamed: "art.scnassets/chimeup.mp3") else {
            print("Failed to load chimeup.mp3")
            return
        }
        chimpupSound.load()
        chimpupSound.volume = 1.0
        chimpupSound.isPositional = false
        let chimpupAction = SCNAction.playAudio(chimpupSound, waitForCompletion: false)
        rootNode.runAction(chimpupAction)
    }
    
    func gameOver() {
        // Stop camera movement
        cameraNode.removeAllActions()
        
        // Make the bunny fall
        let fallAction = SCNAction.moveBy(x: 0, y: -5, z: 0, duration: 1.0)
        let removeAction = SCNAction.removeFromParentNode()
        let sequence = SCNAction.sequence([fallAction, removeAction])
        bunnyNode?.runAction(sequence)
        
        // Ensure ground texture and background are not reset
        // TODO: Display game over screen or perform any other game over logic
        print("Game Over")
        
        // Reapply the grass texture to ensure it remains
        groundNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/grass.png")
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
        
        // Keep the bunny in the scene by moving it along with the camera
        bunnyNode?.position.z = cameraNode.position.z - 9
    }
    
    func moveCamera() {
        let moveCamera = SCNAction.moveBy(x: 0, y: 0, z: -3, duration: 0.3)
        let updateAction = SCNAction.run { _ in self.updateScene() }
        let sequence = SCNAction.sequence([moveCamera, updateAction])
        let repeatAction = SCNAction.repeatForever(sequence)
        cameraNode.runAction(repeatAction)
        print("Camera movement started")
    }
    
    func handleSwipeLeft() {
        if currentLaneIndex > 0 {
            currentLaneIndex -= 1
            moveRunningBunnyToLane(index: currentLaneIndex)
        }
    }
    
    func handleSwipeRight() {
        if currentLaneIndex < lanes.count - 1 {
            currentLaneIndex += 1
            moveRunningBunnyToLane(index: currentLaneIndex)
        }
    }
    
    func moveRunningBunnyToLane(index: Int) {
        let action = SCNAction.moveBy(x: CGFloat(lanes[index] - bunnyNode!.position.x), y: 0, z: 0, duration: 0.2)
        bunnyNode!.runAction(action)
    }
}
