//
//  ViewController.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/25.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var glView: MainOpenGLView!
    
    var scene: MainScene!
    var cam: MainCamera!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        setObj()
    }
    
    func setObj() {
        scene = MainScene.init()
        cam = MainCamera.init(view: glView, scene: scene,
                              pos: GLEV3.init(0, 0, 10), center: GLEV3.init(0, 0, 0))
        scene.setObjs()
        cam.glRun()
    }
    
    var lastMousePos: NSPoint?
    override func mouseDown(with event: NSEvent) {
        lastMousePos = event.locationInWindow
    }
    
    override func mouseDragged(with event: NSEvent) {
        if let pos = lastMousePos {
            let newPos = event.locationInWindow
            let dx = newPos.x - pos.x
            let dy = newPos.y - pos.y
            cam.dir.x -= Float(dy)
            cam.dir.z += Float(dx)
            lastMousePos = newPos
        }
    }
    
    override func scrollWheel(with event: NSEvent) {
        cam.pos.z -= min(max(Float(event.scrollingDeltaY), -1), 1)
    }
    
    override func mouseUp(with event: NSEvent) {
        lastMousePos = nil
    }
    


}

