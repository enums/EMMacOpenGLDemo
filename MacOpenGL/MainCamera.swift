//
//  MainCamera.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

class MainCamera: GLCamera {
    
    let texFilename = ["A", "B", "floor", "cube", "box"]
    
    override func glInit() {
        glEnable(GLenum(GL_TEXTURE_2D))
        glEnable(GLenum(GL_DEPTH_TEST))
        glDepthFunc(GLenum(GL_LESS))
        for i in 0..<texFilename.count {
            GLE.gleGenTexture(idPtr: scene.texIDs[i].pointer)
            GLE.gleUpdateRGBTexture(id: scene.texIDs[i], filename: texFilename[i], type: "jpg")
        }
        let vertex = GLE.gleBuildShader(sourceFilename: "ShaderVertex", shaderType: GLenum(GL_VERTEX_SHADER))
        let fragment = GLE.gleBuildShader(sourceFilename: "ShaderFragment", shaderType: GLenum(GL_FRAGMENT_SHADER))
        shaderProgram = GLE.gleBuildProgram(vertexHandle: vertex, fragmentHandle: fragment)
        glUseProgram(shaderProgram)
        shaderVertex = GLuint(glGetAttribLocation(shaderProgram, "vPosition"))
        shaderTexture = GLuint(glGetAttribLocation(shaderProgram, "a_texCoord"))
        shaderTexType = glGetUniformLocation(shaderProgram, "texType")
        shaderTexY = glGetUniformLocation(shaderProgram, "SamplerY")
        shaderTexU = glGetUniformLocation(shaderProgram, "SamplerU")
        shaderTexV = glGetUniformLocation(shaderProgram, "SamplerV")
        shaderTexA = glGetUniformLocation(shaderProgram, "alpha")
    }
    
    override func glResize(width: CGFloat, height: CGFloat) {
        let fovy = 45.0
        let aspect = Double(width) / Double(height)
        let zNear = 0.1
        let zFar = 2000.0
        let top = zNear * tan(fovy * M_PI / 360.0)
        let bottom = -top
        let left = bottom * aspect
        let right = top * aspect
        glViewport(0, 0, GLsizei(width), GLsizei(height))
        glMatrixMode(GLenum(GL_PROJECTION))
        glLoadIdentity()
        glFrustum(left, right, bottom, top, zNear, zFar)
        glMatrixMode(GLenum(GL_MODELVIEW))
        glLoadIdentity()
    }
    
    override func glDraw() {
        glClearColor(0, 0.2, 0.5, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT) | GLbitfield(GL_DEPTH_BUFFER_BIT))
        glLoadIdentity()
        glTranslatef(-pos.x, -pos.y, -pos.z)
        glRotated(GLdouble(dir.x), 1, 0, 0)
        glRotated(GLdouble(dir.y), 0, 1, 0)
        glRotated(GLdouble(dir.z), 0, 0, 1)
        glTranslatef(-center.x, -center.y, -center.z)
        for (_, obj) in scene.objs {
            obj.draw()
        }
        glFlush()
    }
    
    override func glDeinit() {
        glDeleteTextures(GLsizei(texFilename.count - 1), scene.texIDs[0].pointer)
        glDeleteProgram(shaderProgram)
    }
    
}
