//
//  GameViewController.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//
// GameViewController.swift



// GameViewController.swift
// EndlessRabbit
//
// Created by Ahmed Khan on 04/06/2024.
//
// GameViewController.swift

//  GameViewController.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//
// GameViewController.swift
//  GameViewController.swift
//  EndlessRabbit
//
//  Created by Ahmed Khan on 04/06/2024.
//

/*import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var sceneView: SCNView!
    var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the scene view
        sceneView = SCNView(frame: UIScreen.main.bounds)
        sceneView.allowsCameraControl = false
        sceneView.showsStatistics = false
        
        // Create and configure the game scene
        gameScene = GameScene()
        gameScene.background.contents = UIImage(named: "art.scnassets/MountainsPixel.png") // Set Mountain background
        sceneView.scene = gameScene
        gameScene.moveCamera()
        
        view.addSubview(sceneView)
        
        setupGestures()
        
        print("Scene loaded successfully")
    }
    
    func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeft.direction = .left
        sceneView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        sceneView.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipeLeft() {
        gameScene.handleSwipeLeft()
    }
    
    @objc func handleSwipeRight() {
        gameScene.handleSwipeRight()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        sceneView.frame = UIScreen.main.bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the home indicator
        setNeedsUpdateOfHomeIndicatorAutoHidden()
    }
}
 */
import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var sceneView: SCNView!
    var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the scene view
        sceneView = SCNView(frame: UIScreen.main.bounds)
        sceneView.allowsCameraControl = false
        sceneView.showsStatistics = false
        sceneView.backgroundColor = .clear // Ensure the background is clear
        
        // Create and configure the game scene
        gameScene = GameScene()
        gameScene.background.contents = UIImage(named: "art.scnassets/MountainsPixel.png")
        
        // Set Mountain background
        sceneView.scene = gameScene
        gameScene.moveCamera()
        
        view.addSubview(sceneView)
        
        setupGestures()
        
        print("Scene loaded successfully")
    }
    
    func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeft.direction = .left
        sceneView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        sceneView.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipeLeft() {
        gameScene.handleSwipeLeft()
    }
    
    @objc func handleSwipeRight() {
        gameScene.handleSwipeRight()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        sceneView.frame = view.bounds // Ensure the frame matches the view bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the home indicator
        setNeedsUpdateOfHomeIndicatorAutoHidden()
    }
}
