//
//  ViewController.swift
//  AR Tracking
//
//  Created by Subhankar Acharya on 16/02/20.
//  Copyright © 2020 Subhankar Acharya. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin] 
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true    //defult lighting to the sceneView to show specular
    }
    
    @IBAction func add(_ sender: Any) {
        
        //Parent node configuration - Pyramid
        let node = SCNNode() // a position in space
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = SCNVector3(x: 0.2, y: 0.3, z: -0.2)
        self.sceneView.scene.rootNode.addChildNode(node)  // a scene is what displaying camera view of real world and root node is the origin of 3-D coordinate
        
        //Child node configuration - Box, whose postion is relative to Pyramid's position
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        boxNode.position = SCNVector3(0, -0.05, 0)
        node.addChildNode(boxNode)
        
        //Confiuring and adding the child of the Box Node - Door Node
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        doorNode.position = SCNVector3(0,-0.02,0.053)
        boxNode.addChildNode(doorNode)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

