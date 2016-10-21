//
//  GLCube.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

class GLCube: GLObject {
    
    private var configList = Array<GLTexConfig>()
    var squares = Array<GLSquare>()
    
    override init(pos: GLEV3, dir: GLEV3, size: GLEV3) {
        super.init(pos: pos, dir: dir, size: size)
        let down = GLSquare.init(pos: GLEV3.init(0, 0, 0),
                                 dir: GLEV3.init(0, 0, 0),
                                 size: GLEV3.init(size.x, size.y, 0))
        let top = GLSquare.init(pos: GLEV3.init(0, 0, 0),
                                dir: GLEV3.init(0, 0, 0),
                                size: GLEV3.init(size.x, size.y, 0))
        let left = GLSquare.init(pos: GLEV3.init(0, 0, 0),
                                 dir: GLEV3.init(0, 0, 0),
                                 size: GLEV3.init(size.y, size.z, 0))
        let right = GLSquare.init(pos: GLEV3.init(0, 0, 0),
                                  dir: GLEV3.init(0, 0, 0),
                                  size: GLEV3.init(size.y, size.z, 0))
        let front = GLSquare.init(pos: GLEV3.init(0, 0, 0),
                                  dir: GLEV3.init(0, 0, 0),
                                  size: GLEV3.init(size.x, size.z, 0))
        let behind = GLSquare.init(pos: GLEV3.init(0, 0, 0),
                                   dir: GLEV3.init(0, 0, 0),
                                   size: GLEV3.init(size.x, size.z, 0))
        squares.append(down)
        squares.append(top)
        squares.append(left)
        squares.append(right)
        squares.append(front)
        squares.append(behind)
    }
    
    func setConfigList(list: Array<GLTexConfig>) {
        configList = list
        for i in 0..<6 {
            squares[i].setConfig(config: configList[i])
        }
    }
    
    override func draw() {
        glPushMatrix()
        glTranslatef(pos.x, pos.y, pos.z)
        glRotated(GLdouble(dir.x), 1, 0, 0)
        glRotated(GLdouble(dir.y), 0, 1, 0)
        glRotated(GLdouble(dir.z), 0, 0, 1)
        var matrix = Array<GLfloat>.init(repeating: 0, count: 16)
        var matrixPtr: UnsafeMutablePointer<GLfloat>!
        withUnsafeMutablePointer(to: &matrix[0], { ptr in
            matrixPtr = ptr
        })
        glGetFloatv(GLenum(GL_MODELVIEW_MATRIX), matrixPtr)
        //画底部
        squares[0].draw()
        //移到上面画顶部
        glTranslatef(0, 0, size.z)
        squares[1].draw()
        //画左边
        glLoadMatrixf(matrixPtr)
        glTranslatef(-size.x / 2, 0, size.z / 2)
        glRotated(GLdouble(90), 1, 0, 0)
        glRotated(GLdouble(-90), 0, 1, 0)
        squares[2].draw()
        //画右边
        glRotated(GLdouble(180), 0, 1, 0)
        glTranslatef(0, 0, size.x)
        squares[3].draw()
        //画前面
        glLoadMatrixf(matrixPtr)
        glTranslatef(0, 0, size.z / 2)
        glTranslatef(0, -size.y / 2, 0)
        glRotated(GLdouble(90), 1, 0, 0)
        squares[4].draw()
        //画后面
        glRotated(GLdouble(180), 0, 1, 0)
        glTranslatef(0, 0, size.y)
        squares[5].draw()
        
        glPopMatrix()
    }
}
