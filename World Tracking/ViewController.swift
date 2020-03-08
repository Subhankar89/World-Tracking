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
        let node = SCNNode() // a position in space
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.systemPink
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(x,y,z) // position the node relative to world origin (x-axis, y-axis, z-axis)
        self.sceneView.scene.rootNode.addChildNode(node)  // a scene is what displaying camera view of real world and root node is the origin of 3-D coordinate
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

