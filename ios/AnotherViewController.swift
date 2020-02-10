//
//  AnotherViewController.swift
//  TecateAr
//
//  Created by MacBook on 2/7/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit
import ARKit

@available(iOS 12, *)
@objc class AnotherViewController: UIViewController {
    
    var sceneView: ARSCNView!
    
    let session = ARSession()
    let updateQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).serialSCNQueue")
    var dragonNode: SCNNode!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let button1 = UIButton()
//        let label1 = UILabel()
//
//        button1.setTitle("EXAMPLE", for: .normal)
//        label1.text = "TIEIEIEIE"
//        let stack = UIStackView(arrangedSubviews: [button1, label1])
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//
//        self.view.addSubview(stack)
//        self.view.backgroundColor = UIColor.lightGray
//
//        NSLayoutConstraint.activate([
//            stack.topAnchor.constraint(equalTo: self.view.topAnchor),
//            stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//        ])
        sceneView = ARSCNView()
        view.addSubview(sceneView)
        
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: self.view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            sceneView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as FPS and timing information (useful during development)
        sceneView.showsStatistics = true

        // Enable environment-based lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        setupDependencies()
    }
    
    func setupDependencies() {
        guard let referenceImage = loadImageFromAssets(named: "anchor2"),
            let anchor1 = loadImageFromAssets(named: "anchor1"),
            let anchor3 = loadImageFromAssets(named: "anchor3") else {
            fatalError("Missing expected asset catalog resources.")
        }
        var newReferenceImages = Set<ARReferenceImage>();
        newReferenceImages.insert(referenceImage)
        newReferenceImages.insert(anchor1)
        newReferenceImages.insert(anchor3)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.maximumNumberOfTrackedImages = 1
        configuration.planeDetection = .horizontal
        configuration.detectionImages = newReferenceImages
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func loadImageFromAssets(named: String) -> ARReferenceImage? {
        guard let image = UIImage(named: named) else { return nil }
        
        let arImage = ARReferenceImage(image.cgImage!, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.15)
        // SET YOUR IMAGE NAME
        arImage.name = named;
        
        return arImage
    }

}

@available(iOS 12, *)
extension AnotherViewController: ARSCNViewDelegate {
    
    func collada2SCNNode(filepath:String) -> SCNNode {

        var node = SCNNode()
        let scene = SCNScene(named: filepath)
        var nodeArray = scene!.rootNode.childNodes

        for childNode in nodeArray {

            node.addChildNode(childNode as SCNNode)

        }

        return node

    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard  anchor is ARImageAnchor else { return }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0))
        cubeNode.position = SCNVector3(0, -0.3, -0.5) // SceneKit/AR coordinates are in meters
        //sceneView.scene.rootNode.addChildNode(cubeNode)
        
        
        
//        // 1
//        guard let fruitCakeScene = SCNScene(named: "ARAssets.scnassets/dragon/Dragon 2.5_dae.dae") else {
//            fatalError("Unable to find Dragon 2.5_dae.dae")
//        }
//
//        // 2
//        guard let baseNode = fruitCakeScene.rootNode.childNode(withName: "Cube", recursively: true) else {
//            fatalError("Unable to find baseNode")
//        }/
        //dragonNode = baseNode
        // 3
        dragonNode = collada2SCNNode(filepath: "ARAssets.scnassets/dragon/Dragon 2.5_dae.dae")
        dragonNode.scale = SCNVector3(0.005, 0.005, 0.005)
        dragonNode.position = SCNVector3(0, -0.5, -0.5)
        sceneView.scene.rootNode.addChildNode(dragonNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let imageAnchor = anchor as? ARImageAnchor else { return nil }

        // create a plane at the exact physical width and height of our reference image
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)

        // make the plane have a transparent blue color
        plane.firstMaterial?.diffuse.contents = UIColor.blue.withAlphaComponent(0.8)
        

        // wrap the plane in a node and rotate it so it's facing us
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2

        // now wrap that in another node and send it back
        let node = SCNNode()
        node.addChildNode(planeNode)
        
        
        return node
    }
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        dragonNode.worldPosition = node.position
    }
    
    func addFoodModelTo(position: SCNNode) {
    }
}

