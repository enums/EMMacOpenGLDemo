//
//  GLCamera.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import Cocoa

class GLCamera {
    
    weak var view: GLView!
    weak var scene: GLScene!
    
    var pos: GLEV3!
    var center: GLEV3!
    var dir: GLEV3!
    
    var shaderProgram: GLuint = 0
    var shaderVertex: GLuint = 0
    var shaderTexture: GLuint = 0
    var shaderTexType: GLint = 0
    var shaderTexY: GLint = 0
    var shaderTexU: GLint = 0
    var shaderTexV: GLint = 0
    var shaderTexA: GLint = 0
    
    init(view: GLView, scene: GLScene,
         pos: GLEV3,
         dir: GLEV3 = GLEV3.init(0, 0, 0),
         center: GLEV3 = GLEV3.init(0, 0, 0)) {
        self.view = view
        self.scene = scene
        view.camera = self
        self.pos = pos
        self.dir = dir
        self.center = center
        _glInit()
    }
    
    func glRun() {
        GLE.gleRun(sender: self)
    }
    
    func _glInit() {
        GLE.gleBindCamera(camera: self)
        let context = view.openGLContext!
        context.makeCurrentContext()
        CGLLockContext(context.cglContextObj!)
        glInit()
        CGLUnlockContext(context.cglContextObj!)
    }
    
    func glInit() { }
    
    func _glResize(width: CGFloat, height: CGFloat) {
        GLE.gleBindCamera(camera: self)
        let context = view.openGLContext!
        context.makeCurrentContext()
        CGLLockContext(context.cglContextObj!)
        glResize(width: width, height: height)
        CGLUnlockContext(context.cglContextObj!)
    }
    
    func glResize(width: CGFloat, height: CGFloat) { }
    
    func _glDraw() {
        let context = view.openGLContext!
        context.makeCurrentContext()
        GLE.gleBindCamera(camera: self)
        CGLLockContext(context.cglContextObj!)
        glDraw()
        CGLUnlockContext(context.cglContextObj!)
    }
    
    func glDraw() { }
    
    func _glDeinit() {
        let context = view.openGLContext!
        context.makeCurrentContext()
        GLE.gleBindCamera(camera: self)
        GLE.gleStop()
        CGLLockContext(context.cglContextObj!)
        glDeinit()
        CGLUnlockContext(context.cglContextObj!)
    }
    
    func glDeinit() { }
}
