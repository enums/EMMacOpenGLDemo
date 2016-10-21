//
//  GLObject.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

protocol GLDrawable {
    func draw()
}

class GLObject: GLDrawable {
    var pos: GLEV3!
    var dir: GLEV3!
    var size: GLEV3!
    
    init(pos: GLEV3 = GLEV3.init(0, 0, 0),
         dir: GLEV3 = GLEV3.init(0, 0, 0),
         size: GLEV3 = GLEV3.init(0, 0, 0)) {
        self.pos = pos
        self.dir = dir
        self.size = size
    }
    
    
    func setPos(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
        let pos = GLEV3.init(x, y, z)
        setPos(pos)
    }
    
    func setDir(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
        let pos = GLEV3.init(x, y, z)
        setDir(pos)
    }
    
    func setSize(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
        let pos = GLEV3.init(x, y, z)
        setSize(pos)
    }
    
    func setPos(_ v3: GLEV3) {
        self.pos = v3
    }
    
    func setDir(_ v3: GLEV3) {
        self.dir = v3
    }
    
    func setSize(_ v3: GLEV3) {
        self.size = v3
    }
    
    func draw() {
        
    }
    
    
}
