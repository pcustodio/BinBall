//
//  ViewController.swift
//  BinBall
//
//  Created by Paulo Custódio on 18/07/2020.
//  Copyright © 2020 Paulo Custódio. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add lights
        sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        addBin()
    }
    
    //add trash can to scene
    func addBin() {
        guard let binScene = SCNScene(named: "art.scnassets/trash_can.scn") else {
            return
        }
        guard let binNode = binScene.rootNode.childNode(withName: "Bin", recursively: false) else {
            return
        }
        binNode.position = SCNVector3(x: 0, y:0, z: -3)
        sceneView.scene.rootNode.addChildNode(binNode)
    }
    
    //recognize gestures
    func registerGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tap)
    }
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        print("will it work")
        //when we tap on screen we want a ball to be created and positioned at camera center point
        
        //scene view to be accessed
        guard let sceneView = gestureRecognizer.view as? ARSCNView else {
            return
        }
        
        //access the center point
        guard let  centerPoint = sceneView.pointOfView else {
            return
        }
        
        //transform matrix contains orientation and location of camera so now we can now determine position of camera
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    


    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
