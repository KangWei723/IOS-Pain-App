//
//  ModelView.swift
//  Pain App
//
//  Created by Shrey Patel on 11/30/22.
//

import SwiftUI
import SceneKit

extension SCNGeometryElement {
    func getVertices(index: Int) -> [Int] {
        func vectorFromData<UInt: BinaryInteger>(_ float: UInt.Type, index: Int) -> [Int] {
            assert(bytesPerIndex == MemoryLayout<UInt>.size)
            let vectorData = UnsafeMutablePointer<UInt>.allocate(capacity: 3)
            let buffer = UnsafeMutableBufferPointer(start: vectorData, count: 3 * bytesPerIndex)
            let stride = 3 * index
            self.data.copyBytes(to: buffer, from: stride * bytesPerIndex..<(stride * bytesPerIndex) + 3 * bytesPerIndex)
            return [Int(vectorData[0]), Int(vectorData[1]), Int(vectorData[2])]
        }
        
            switch bytesPerIndex {
            case 2:
                return vectorFromData(Int16.self, index: index)
            case 4:
                return vectorFromData(Int32.self, index: index)
            case 8:
                return []
            default:
                return []
        }
    }
}

extension SCNGeometrySource {
    func getVertex(index: Int) -> SCNVector3 {
        let stride = self.dataStride
        let offset = self.dataOffset
        let componentsPerVector = self.componentsPerVector
        let bytesPerVector = componentsPerVector * self.bytesPerComponent

        func vectorFromData<FloatingPoint: BinaryFloatingPoint>(_ float: FloatingPoint.Type, index: Int) -> SCNVector3 {
            assert(bytesPerComponent == MemoryLayout<FloatingPoint>.size)
            let vectorData = UnsafeMutablePointer<FloatingPoint>.allocate(capacity: componentsPerVector)
            defer {
                vectorData.deallocate()
            }
            let buffer = UnsafeMutableBufferPointer(start: vectorData, count: componentsPerVector)
            let rangeStart = index * stride + offset
            self.data.copyBytes(to: buffer, from: rangeStart..<(rangeStart + bytesPerVector))
            return SCNVector3(
                CGFloat.NativeType(vectorData[0]),
                CGFloat.NativeType(vectorData[1]),
                CGFloat.NativeType(vectorData[2])
            )
        }
            switch bytesPerComponent {
            case 4:
                return vectorFromData(Float32.self, index: index)
            case 8:
                return vectorFromData(Float64.self, index: index)
            case 16:
                return vectorFromData(Float64.self, index: index)
            default:
                return SCNVector3Zero
            }
    }
}

extension ModelView {
    class Coordinator: NSObject, SCNProgramDelegate, UIGestureRecognizerDelegate {
        var taps: Set<Int>
        
        override init() {
            self.taps = Set<Int>()
        }
        
        func program(_ program: SCNProgram, handleError error: Error) {
            print(error)
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc func processTap(_ gesture: UITapGestureRecognizer) {
            let currentLocation = gesture.location(in: gesture.view)
            let scnView = gesture.view as? SCNView
            
            guard let hitTestNode = scnView!.hitTest(currentLocation, options: nil).first else { return }
            
            if hitTestNode.node.name == "Basemesh" {
                let index = hitTestNode.faceIndex
                let node = hitTestNode.node
                
                if taps.contains(index) {
                    taps.remove(index)
                    let triangleNode = node.childNode(withName: "\(index)", recursively: true)
                    triangleNode?.childNodes.forEach { child in
                        child.removeFromParentNode()
                        child.geometry = nil
                    }
                    triangleNode?.removeFromParentNode()
                    triangleNode?.geometry = nil
                    scnView?.sceneTime += 1
                } else {
                    taps.insert(index)
                    createTriangle(index: index, node: node)
                }
            } else if hitTestNode.node.name != nil {
                taps.remove(Int(hitTestNode.node.name!) ?? 0)
                hitTestNode.node.childNodes.forEach { child in
                    child.removeFromParentNode()
                    child.geometry = nil
                }
                hitTestNode.node.removeFromParentNode()
                hitTestNode.node.geometry = nil
            }
            
        }
        
        func createTriangle(index: Int, node: SCNNode) {
            
            let face = node.geometry?.elements[0].getVertices(index: index)
            let vertex = [node.geometry!.sources[0].getVertex(index: face![0]),
                          node.geometry!.sources[0].getVertex(index: face![1]),
                          node.geometry!.sources[0].getVertex(index: face![2])
            ]
            
            let vertexData = Data(bytes: vertex, count: 3 * MemoryLayout<Float>.size * 3)
            
            let geometrySource = SCNGeometrySource(data: vertexData, semantic: .vertex, vectorCount: 3,
                                                   usesFloatComponents: true,
                                                   componentsPerVector: 3,
                                                   bytesPerComponent: MemoryLayout<Float>.size,
                                                   dataOffset: 0,
                                                   dataStride: 0)
             
            let indices: [UInt32] = [
                0, 1, 2
            ]
            
            let triangleElement = SCNGeometryElement(indices: indices, primitiveType: .triangles)
            
            let triangleGeometry = SCNGeometry(sources: [geometrySource], elements: [triangleElement])
            
            let triangleNode = SCNNode(geometry: triangleGeometry)
            triangleNode.name = String(index)

            node.addChildNode(triangleNode)
        }
    }
}

struct ModelView: UIViewRepresentable {
    
    private var scnView = SCNView(frame: .zero, options: ["preferredRenderingAPI": "metal"])
    @Binding var selectedPicker: HighlightAreaPage.PickerState
    @Binding var selectedArea: HighlightAreaPage.AreaState
    
    init(selectedPicker: Binding<HighlightAreaPage.PickerState>, selectedArea: Binding<HighlightAreaPage.AreaState>) {
        _selectedArea = selectedArea
        _selectedPicker = selectedPicker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    typealias UIViewType = SCNView
    typealias SCNBufferBindingBlock = (SCNBufferStream, SCNNode, SCNShadable, SCNRenderer) -> Void
    
    func makeUIView(context: UIViewRepresentableContext<ModelView>) -> SCNView {
        self.scnView.scene = SCNScene()
        self.scnView.allowsCameraControl = true
        scnView.debugOptions = .showWireframe
        self.scnView.autoenablesDefaultLighting = true
        self.scnView.rendersContinuously = true
        
        var assetNode = SCNScene(named: "3D Model.scn")?.rootNode.childNodes[0]
        assetNode = assetNode?.childNode(withName: "Basemesh", recursively: true)!
        assetNode?.geometry?.firstMaterial?.lightingModel = .physicallyBased
        
        self.scnView.scene?.rootNode.addChildNode(assetNode!)
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.processTap))
        tapGesture.delegate = context.coordinator
        self.scnView.addGestureRecognizer(tapGesture)
        
        return self.scnView
    }
        
    func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<ModelView>) {
        
        let myScene = uiView.scene
        if selectedPicker == .front {
            myScene!.rootNode.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1))
        } else if selectedPicker == .back {
            myScene!.rootNode.runAction(SCNAction.rotateTo(x: 0, y: 3.15, z: 0, duration: 1))
        }
        
        if selectedArea == .lh {
            myScene!.rootNode.runAction(SCNAction.move(to: SCNVector3(x: 35, y: -25, z: 140), duration: 1))
        } else if selectedArea == .rh {
            myScene!.rootNode.runAction(SCNAction.move(to: SCNVector3(x: -35, y: -25, z: 140), duration: 1))
        } else if selectedArea == .ll {
            myScene!.rootNode.runAction(SCNAction.move(to: SCNVector3(x: 30, y: 45, z: 110), duration: 1))
        } else if selectedArea == .rl {
            myScene!.rootNode.runAction(SCNAction.move(to: SCNVector3(x: -30, y: 45, z: 110), duration: 1))
        } else if selectedArea == .none {
            myScene!.rootNode.runAction(SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 0), duration: 1))
        }
    }
}
