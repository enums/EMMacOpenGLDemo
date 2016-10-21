//
//  GLSquare.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

class GLSquare: GLObject {
    private var config: GLTexConfig!
    
    override init(pos: GLEV3, dir: GLEV3, size: GLEV3) {
        super.init(pos: pos, dir: dir, size: size)
    }
    
    func setConfig(config: GLTexConfig) {
        self.config = config
    }
    
    override func draw() {
        super.draw()
        glPushMatrix()
        glTranslatef(pos.x, pos.y, pos.z)
        glRotated(GLdouble(dir.x), 1, 0, 0)
        glRotated(GLdouble(dir.y), 0, 1, 0)
        glRotated(GLdouble(dir.z), 0, 0, 1)
        GLE.gleDrawSquare(pos: pos, size: size, config: config)
        glPopMatrix()
    }
}
