//
//  ModelView.swift
//  Pain App
//
//  Created by Shrey Patel on 11/30/22.
//

import SwiftUI
import SceneKit
import SceneKit.ModelIO
import Metal
import MetalKit
import UIKit
import SpriteKit

struct Touches {
    //    var touches: [Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
    var touches: Int = -1
}

struct Size {
    var size: Int = 0
}

extension SCNGeometryElement {

    /// Gets the `Element` vertices
    func getVertices(index: Int) -> [Int] {
        
        func vectorFromData<UInt: BinaryInteger>(_ float: UInt.Type, index: Int) -> [Int] {
            assert(bytesPerIndex == MemoryLayout<UInt>.size)
            let vectorData = UnsafeMutablePointer<UInt>.allocate(capacity: 3)
            let buffer = UnsafeMutableBufferPointer(start: vectorData, count: 3 * bytesPerIndex)
            let stride = 3 * index
            self.data.copyBytes(to: buffer, from: stride * bytesPerIndex..<(stride * bytesPerIndex) + 3 * bytesPerIndex)
            return [Int(vectorData[0]), Int(vectorData[1]), Int(vectorData[2])]
        }
        
//        let vectors = [SCNVector3](repeating: SCNVector3Zero, count: self.primitiveCount)
//        return vectors.indices.map { index -> SCNVector3 in
            switch bytesPerIndex {
            case 2:
                return vectorFromData(Int16.self, index: index)
            case 4:
                return vectorFromData(Int32.self, index: index)
            case 8:
                return []
            default:
                return []
//            }
        }
    }
}

extension SCNGeometryElement {
    var vertices: [[Int]] {
//        let stride = self.
//        let offset = self.dataOffset
//        let componentsPerVector = self.
//        let bytesPerVector = self.bytesPerIndex

        func vectorFromData<UInt: BinaryInteger>(_ float: UInt.Type, index: Int) -> [Int] {
            assert(bytesPerIndex == MemoryLayout<UInt>.size)
            let vectorData = UnsafeMutablePointer<UInt>.allocate(capacity: 3)
            defer {
                vectorData.deallocate()
            }
            let buffer = UnsafeMutableBufferPointer(start: vectorData, count: 3)
            let rangeStart = index * 3 * bytesPerIndex
            self.data.copyBytes(to: buffer, from: rangeStart..<(rangeStart) + 3 * bytesPerIndex)
            return [
                Int(UInt(vectorData[0])),
                Int(UInt(vectorData[1])),
                Int(UInt(vectorData[2]))
            ]
        }

        let vectors = [[Int]](repeating: ([Int](repeating: 0, count: 3)), count: primitiveCount)
        return vectors.indices.map { index -> [Int] in
            switch bytesPerIndex {
            case 2:
                return vectorFromData(Int16.self, index: index)
            case 4:
                return vectorFromData(Int32.self, index: index)
            case 8:
                return vectorFromData(Int64.self, index: index)
//            case 16:
//                return vectorFromData(Float64.self, index: index)
            default:
                return []
            }
        }
    }
}

extension SCNGeometrySource {
    var vertices: [SCNVector3] {
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

        let vectors = [SCNVector3](repeating: SCNVector3Zero, count: self.vectorCount)
        return vectors.indices.map { index -> SCNVector3 in
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

//        let vectors = [SCNVector3](repeating: SCNVector3Zero, count: self.vectorCount)
//        return vectors.indices.map { index -> SCNVector3 in
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
        
        var touches = Touches()
        var touches2: [Int] = []
        var scnView: SCNView
        var taps: Set<Int>
        
        init(touches: Touches, scnView: SCNView) {
            self.touches = touches
            self.scnView = scnView
            self.taps = Set<Int>()
        }
        
        func program(_ program: SCNProgram, handleError error: Error) {
            print(error)
            print("hello")
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        @objc func processTap(_ gesture: UITapGestureRecognizer) {
            let currentLocation = gesture.location(in: gesture.view)
            let scnView = gesture.view as? SCNView
            print("Tapped: \(currentLocation)")
            
            guard let hitTestNode = scnView!.hitTest(currentLocation, options: nil).first else { return }
            
            if hitTestNode.node.name == "Basemesh" {
                //                self.touches.touches.append(hitTestNode.faceIndex)
                var index = hitTestNode.faceIndex
                var node = hitTestNode.node
                
                if(taps.contains(index)) {
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
                
//                var vertices = hitTestNode.node.geometry?.elements[0].getVertices(index: index)
//
//                //                vertices?.forEach { index in
//                //                    print(node.geometry?.sources[0].getVertices(index: index))
//                //                }
//
//                let count = node.geometry?.sources[0].vectorCount
//                var colors = [SCNVector4](repeating: SCNVector4(x: 0.5, y: 0.5, z: 0.5, w: 1.0), count: count!)
//                taps.forEach { tap in
//                    vertices = hitTestNode.node.geometry?.elements[0].getVertices(index: tap)
//                    colors[vertices![0]] = SCNVector4(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
//                    colors[vertices![1]] = SCNVector4(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
//                    colors[vertices![2]] = SCNVector4(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
//                }
//
//                //                print(colors[vertices![2]])
//
//                let colorsData = Data(bytes: colors, count: 4 * MemoryLayout<Float>.size * count!)
//
//                let colorSource: SCNGeometrySource = SCNGeometrySource(data: colorsData, semantic: .color, vectorCount: count!,
//                                                                       usesFloatComponents: true, componentsPerVector: 4,
//                                                                       bytesPerComponent: MemoryLayout<Float>.size, dataOffset: 0,
//                                                                       dataStride: 0)
//
//                let sources: [SCNGeometrySource] = [(node.geometry?.sources[0])!,
//                                                    (node.geometry?.sources[1])!,
//                                                    (node.geometry?.sources[3])!,
//                                                    colorSource]
//
//                let element = SCNGeometryElement(data: node.geometry?.elements[0].data, primitiveType: .triangles,
//                                                 primitiveCount: (node.geometry?.elements[0].primitiveCount)!,
//                                                 bytesPerIndex: (node.geometry?.elements[0].bytesPerIndex)!)
//
//                let outlineProgram = SCNProgram()
//                outlineProgram.vertexFunctionName = "outline_vertex"
//                outlineProgram.fragmentFunctionName = "outline_fragment"
//
//
//                let geometry = SCNGeometry(sources: sources, elements: [element])
//                let material = SCNMaterial()
//                //                material.fillMode = .lines
//                //                material.cullMode = .
//                material.program = outlineProgram
//
//
//                //                let material2 = SCNMaterial()
//                //                material2.transparency = 0.2
//                //                material2.fillMode = .lines
//                //                material2.diffuse.contents =
//                //                material2.fillMode = .lines
//
//                //        //        material.diffuse.contents = UIColor.orange
//                //                material.lightingModel = .physicallyBased
//                geometry.materials = [material]
//                //
//                //                scnView?.scene?.rootNode.repl
//                SCNTransaction.begin()
//                scnView.scene!.rootNode.enumerateChildNodes { (node, stop) in
//                    node.removeFromParentNode()
//                }
//
//                var otherNode = SCNNode(geometry: geometry)
//                otherNode.name = "Basemesh"
//
//                scnView.scene?.rootNode.addChildNode(otherNode)
//                print(scnView.scene?.rootNode.childNodes.count)
//                SCNTransaction.commit()
//                self.touches.touches = index
//                print(index)
//                self.touches2.append(index)
                //                hitTestNode.node.geometry?.firstMaterial?.setValue(NSData(bytes: self.touches, length: self.touches.count), forKey: "touches")
                print("Basemesh location: \(hitTestNode.localCoordinates)")
            } else if (hitTestNode.node.name != nil) {
                taps.remove(Int(hitTestNode.node.name!) ?? 0)
                hitTestNode.node.childNodes.forEach { child in
                    child.removeFromParentNode()
                    child.geometry = nil
                }
                hitTestNode.node.removeFromParentNode()
                hitTestNode.node.geometry = nil
//                scnView?.sceneTime += 1
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
            
//            let triangleMaterial = SCNMaterial()
//            triangleMaterial.diffuse.contents = UIColor.blue
//            triangleMaterial.lightingModel = .physicallyBased
//            triangleGeometry.materials = [triangleMaterial]
            
            let triangleNode = SCNNode(geometry: triangleGeometry)
            triangleNode.name = String(index)
        //            triangleNode.position = SCNVector3(x: triangleNode.position.x,
        //                                               y: triangleNode.position.y,
        //                                               z: triangleNode.position.z * 1.05
        //            )
        //
//            triangleNode.addChildNode(createLineNode(fromPos: vertex[0], toPos: vertex[1], color: UIColor.black))
//            triangleNode.addChildNode(createLineNode(fromPos: vertex[0], toPos: vertex[2], color: UIColor.black))
//            triangleNode.addChildNode(createLineNode(fromPos: vertex[1], toPos: vertex[2], color: UIColor.black))
            
            self.scnView.scene?.rootNode.childNodes[0].addChildNode(triangleNode)
        }
        
        func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
            let indices: [Int32] = [0, 1]

            let source = SCNGeometrySource(vertices: [vector1, vector2])
            let element = SCNGeometryElement(indices: indices, primitiveType: .line)

            return SCNGeometry(sources: [source], elements: [element])
        }
        
        func createLineNode(fromPos origin: SCNVector3, toPos destination: SCNVector3, color: UIColor) -> SCNNode {
            let line = lineFrom(vector: origin, toVector: destination)
            let lineNode = SCNNode(geometry: line)
            let planeMaterial = SCNMaterial()
            planeMaterial.diffuse.contents = color
            line.materials = [planeMaterial]

            return lineNode
        }
    }
}

struct ModelView: UIViewRepresentable {
    
    private var touches = Touches()
    private var scnView = SCNView(frame: .zero, options: ["preferredRenderingAPI": "metal"])
    
    func makeCoordinator() -> Coordinator {
        Coordinator(touches: touches, scnView: self.scnView)
    }
    
    typealias UIViewType = SCNView
    typealias SCNBufferBindingBlock = (SCNBufferStream, SCNNode, SCNShadable, SCNRenderer) -> Void
    
    func makeUIView(context: UIViewRepresentableContext<ModelView>) -> SCNView {
        self.scnView.scene = SCNScene()
        self.scnView.allowsCameraControl = true
        scnView.debugOptions = .showWireframe
        self.scnView.autoenablesDefaultLighting = true
        self.scnView.rendersContinuously = true
        
//        self.scnView.currentRenderCommandEncoder?.
        
//        self.scnView.device?.makeDefaultLibrary()
        
        let mdlAsset = MDLAsset(url: Bundle.main.url(forResource: "3D Model", withExtension: "usdz")!)

        mdlAsset.loadTextures()
        let asset = mdlAsset.object(at: 0)
        var assetNode = SCNNode(mdlObject: asset)
        assetNode = assetNode.childNode(withName: "Basemesh", recursively: true)!
        assetNode.geometry?.firstMaterial?.lightingModel = .physicallyBased
//        let outlineProgram = SCNProgram()
//        outlineProgram.vertexFunctionName = "outline_vertex"
//        outlineProgram.fragmentFunctionName = "outline_fragment"
        
        
        
//        outlineProgram.handleBinding(ofBufferNamed: "touches", frequency: .perNode) { (bufferStream, node, shadable, renderer) in
////            print("hello")
////            print(context.coordinator.touches.touches.count)
//            bufferStream.writeBytes(&context.coordinator.touches, count: MemoryLayout<Touches>.stride)
//        }
//
//        outlineProgram.handleBinding(ofBufferNamed: "touches2", frequency: .perFrame) { (bufferStream, node, shadable, renderer) in
////            print("hello")
////            print(context.coordinator.touches.touches.count)
//            print(context.coordinator.touches2)
//            bufferStream.writeBytes(context.coordinator.touches2, count: context.coordinator.touches2.count * MemoryLayout<Int>.size)
//        }
//
//        outlineProgram.handleBinding(ofBufferNamed: "size", frequency: .perFrame) { (bufferStream, node, shadable, renderer) in
////            print("hello")
////            print(context.coordinator.touches.touches.count)
//            var size = Size()
//            size.size = context.coordinator.touches2.count
//            bufferStream.writeBytes(&size, count: MemoryLayout<Size>.stride)
//        }
        
//        let count = assetNode.geometry?.sources[0].vectorCount
//        let colors = [SCNVector4](repeating: SCNVector4(x: 0.5, y: 0.5, z: 0.5, w: 1.0), count: count!)
//        let colorsData = Data(bytes: colors, count: 4 * MemoryLayout<Float>.size * count!)
//
//        let colorSource: SCNGeometrySource = SCNGeometrySource(data: colorsData, semantic: .color, vectorCount: count!,
//                                                               usesFloatComponents: true, componentsPerVector: 4,
//                                                               bytesPerComponent: MemoryLayout<Float>.size, dataOffset: 0,
//                                                               dataStride: 0)
////        print(assetNode.geometry?)
//
//        assetNode.geometry?.elements.forEach { element in
//            print(element.primitiveType)
//            print(element.primitiveCount)
//        }
//        print(MemoryLayout<Int>.size)
//
//        let sources: [SCNGeometrySource] = [(assetNode.geometry?.sources[0])!,
//                                            (assetNode.geometry?.sources[1])!,
//                                            (assetNode.geometry?.sources[2])!,
//                                            colorSource]
//
//        let element = SCNGeometryElement(data: assetNode.geometry?.elements[0].data, primitiveType: .triangles,
//                                         primitiveCount: (assetNode.geometry?.elements[0].primitiveCount)!,
//                                         bytesPerIndex: (assetNode.geometry?.elements[0].bytesPerIndex)!)
//
//        let geometry = SCNGeometry(sources: sources, elements: [element])
//        let material = SCNMaterial()
////        material.cullMode = .front
////        material.program = outlineProgram
////        material.setValue(assetNode.geometry?.sources[0], forKey: "vertices")
////        material.setValue(assetNode.geometry?.elements[0], forKey: "traingles")
//
//////        material.diffuse.contents = UIColor.orange
////        material.lightingModel = .physicallyBased
//        geometry.materials = [material]
//
//        assetNode = SCNNode(geometry: geometry)
//        assetNode.name = "Basemesh"
//
//        assetNode.geometry?.sources.forEach { source in
//            print(source.semantic.rawValue)
//        }
        
//        print(self.scnView.device?.currentAllocatedSize)
        
//        let vertex = [SCNVector3(0.0, 0.0, 0.0)]
//        for i in 0..<(assetNode.geometry?.elements[0].primitiveCount)! {
//
//
//            assetNode.addChildNode(triangleNode)
//        }
        self.scnView.scene?.rootNode.addChildNode(assetNode)
            
//        assetNode.addChildNode(triangleNode)
        
//        assetNode.castsShadow = true
        
//        outlineProgram.handleBinding(ofBufferNamed: "Basemesh", frequency: .perFrame, handler: SCN)
//        assetNode.geometry?.firstMaterial?.program = outlineProgram
        
        
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.processTap))
        tapGesture.delegate = context.coordinator
        self.scnView.addGestureRecognizer(tapGesture)

        
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.red
        
//        material.program = outlineProgram
//        outlineProgram.delegate = context.coordinator
        
//        scnView.scene?.rootNode.geometry?.program? = outlineProgram
//        scnView.scene?.rootNode.childNodes.forEach { child in
//            child.geometry?.materials = [material]
//        }
        
//        scnView.scene?.rootNode.geometry?.firstMaterial?.emission.contents = UIColor.red
//        scnView.scene?.rootNode.geometry?.materials = [material]
        
        return self.scnView
    }
    
//    func SC
    
    func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<ModelView>) {
//        uiView.scene?.rootNode.childNodes[0].simdLocalRotate(by: simd_quatf(angle: 0.5, axis: SIMD3(SCNVector3(x: 0, y: 0, z: 0))))
    }
}

struct ModelView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
