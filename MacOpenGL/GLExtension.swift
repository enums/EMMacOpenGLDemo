//
//  GLExtension.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/25.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import Cocoa
import OpenGL.GL
import GLKit
import CoreVideo

class GLEV3 {
    var x: GLfloat = 0
    var y: GLfloat = 0
    var z: GLfloat = 0
    
    init() {
        
    }
    
    init(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    func set(_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
        self.x = x
        self.y = y
        self.z = z
    }
}

class GLE {
    
    static weak var camera: GLCamera?
    
    static func gleBindCamera(camera: GLCamera) {
        self.camera = camera
    }
    
    static var displayLink: CVDisplayLink?
    static func gleRun(sender: GLCamera) {
        CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        CVDisplayLinkSetOutputHandler(displayLink!) { (_, _, _, _, _) -> CVReturn in
            sender._glDraw()
            return kCVReturnSuccess
        }
        CVDisplayLinkStart(displayLink!)
    }
    
    static func gleStop() {
        CVDisplayLinkStop(displayLink!)
    }
    

    static func gleGenTexture(idPtr: UnsafeMutablePointer<GLuint>) {
        glGenTextures(1, idPtr);
        glBindTexture(GLenum(GL_TEXTURE_2D), idPtr.pointee);
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR);
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR);
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_REPEAT);
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_REPEAT);
        glBindTexture(GLenum(GL_TEXTURE_2D), 0);
    }
    
    
    static func gleUpdateRGBTexture(id: GLuint, filename: String, type: String? = nil) {
        autoreleasepool {
            let pathname = Bundle.main.path(forResource: filename, ofType: type)!
            let image = NSImage.init(contentsOfFile: pathname)!
            let size = image.size
            var rect = NSRect.init(x: 0, y: 0, width: size.width, height: size.height)
            var rectPtr: UnsafeMutablePointer<NSRect>!
            withUnsafeMutablePointer(to: &rect, { ptr in
                rectPtr = ptr
            })
            let cgImage = image.cgImage(forProposedRect: rectPtr, context: nil, hints: nil)!
            gleUpdateRGBTexture(id: id, image: cgImage)
        }
    }
    
    static func gleUpdateRGBTexture(id: GLuint, image: CGImage) {
        let width = image.width
        let height = image.height
        let dataSize = width * height * 4
        let data = UnsafeMutablePointer<UInt8>.allocate(capacity: dataSize)
        autoreleasepool {
            let colorSpace = image.colorSpace!
            let context = CGContext.init(data: data, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
            context.draw(image, in: CGRect.init(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
            glBindTexture(GLenum(GL_TEXTURE_2D), id)
            glTexImage2D(GLenum(GL_TEXTURE_2D), 0, GL_RGBA, GLsizei(width), GLsizei(height), 0, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), data)
            glBindTexture(GLenum(GL_TEXTURE_2D), 0)
        }
        free(data)
    }
    
    static func gleDrawSquare(pos: GLEV3, size: GLEV3, config: GLTexConfig) {
        let l = size.x / 2
        let w = size.y / 2
        let posX = pos.x
        let posY = pos.y
        let posZ = pos.z
        var verCoord = Array<Float>.init(repeating: 0, count: 12)
        verCoord[0] = posX - l;     verCoord[1] = posY - w;     verCoord[2] = posZ;
        verCoord[3] = posX + l;     verCoord[4] = posY - w;     verCoord[5] = posZ;
        verCoord[6] = posX + l;     verCoord[7] = posY + w;     verCoord[8] = posZ;
        verCoord[9] = posX - l;     verCoord[10] = posY + w;     verCoord[11] = posZ;
        let texCoord: Array<Float> = [
            0,                      config.texHeightRepeat,
            config.texWidthRepeat,  config.texHeightRepeat,
            config.texWidthRepeat,  0,
            0,                      0,
            ]
        gleDrawSquare(verCoord: verCoord, texCoord: texCoord, config: config)
    }
    
    static func gleDrawSquare(verCoord: Array<Float>, texCoord: Array<Float>,
                              config: GLTexConfig) {
        var verCoord1 = Array<Float>.init(repeating: 0, count: 9)
        var texCoord1 = Array<Float>.init(repeating: 0, count: 9)
        var verCoord2 = Array<Float>.init(repeating: 0, count: 9)
        var texCoord2 = Array<Float>.init(repeating: 0, count: 9)
        var index = 0
        for i in 0..<3 * 3 {
            verCoord1[index] = verCoord[i]
            index += 1
        }
        index = 0
        for i in 0..<3 * 2 {
            texCoord1[index] = texCoord[i]
            index += 1
        }
        index = 0
        for i in 0..<1 * 3 {
            verCoord2[index] = verCoord[i]
            index += 1
        }
        for i in 3 * 3..<4 * 3 {
            verCoord2[index] = verCoord[i]
            index += 1
        }
        for i in 2 * 3..<3 * 3 {
            verCoord2[index] = verCoord[i]
            index += 1
        }
        
        index = 0
        for i in 0..<1 * 2 {
            texCoord2[index] = texCoord[i]
            index += 1
        }
        for i in 3 * 2..<4 * 2 {
            texCoord2[index] = texCoord[i]
            index += 1
        }
        for i in 2 * 2..<3 * 2 {
            texCoord2[index] = texCoord[i]
            index += 1
        }
        gleDrawTriangle(verCoord: verCoord1, texCoord: texCoord1, config: config)
        gleDrawTriangle(verCoord: verCoord2, texCoord: texCoord2, config: config)
        
    }
    
    static func gleDrawTriangle(verCoord: Array<Float>, texCoord: Array<Float>,
                             config: GLTexConfig) {
        let camVerCoord: Array<Float> = [camera!.center.x, camera!.center.y, camera!.center.z]
        drawSurface(verCoord: verCoord, camVerCoord: camVerCoord, texCoord: texCoord,
                    config: config, drawCount: 3)
    }
    
    static func drawSurface(verCoord: Array<Float>,
                            camVerCoord: Array<Float>,
                            texCoord: Array<Float>,
                            config: GLTexConfig, drawCount: Int) {
        switch config.type! {
        case .RGB:
            gleDrawRGBSurface(texID: config.texID!,
                           alpha: config.alpha,
                           vercoord: verCoord,
                           camVercoord: camVerCoord,
                           texcoord: texCoord,
                           drawCount: GLsizei(drawCount))
        case .YUV:
            break
        }
    }
    
    static func gleDrawRGBSurface(texID: GLuint,
                               alpha: Float,
                               vercoord: Array<Float>,
                               camVercoord: Array<Float>,
                               texcoord: Array<Float>,
                               drawCount: GLsizei) {
        if camera == nil {
            return
        }
        glUniform1i(camera!.shaderTexType, 0);
        glActiveTexture(GLenum(GL_TEXTURE0));
        glBindTexture(GLenum(GL_TEXTURE_2D), texID);
        glUniform1i(camera!.shaderTexY, 0);
        glUniform1f(camera!.shaderTexA, alpha);
        glVertexAttribPointer(camera!.shaderVertex, 3, GLenum(GL_FLOAT), 0, 0, vercoord);
        glEnableVertexAttribArray(camera!.shaderVertex);
        glVertexAttribPointer(camera!.shaderTexture, 2, GLenum(GL_FLOAT), 0, 0, texcoord);
        glEnableVertexAttribArray(camera!.shaderTexture);
        glDrawArrays(GLenum(GL_TRIANGLES), 0, drawCount);
        glBindTexture(GLenum(GL_TEXTURE_2D), 0);
        
    }
    
    
    
    static func gleBuildShader(sourceFilename: String, type: String = "string", shaderType: GLenum) -> GLuint{
        var shaderHandle = glCreateShader(shaderType)
        if shaderHandle != 0 {
            //读取文本
            let sourcePath = Bundle.main.path(forResource: sourceFilename, ofType: type)!
            let sourceData = NSData.init(contentsOfFile: sourcePath)!
            //获取长度
            var dataSize: GLint = GLint(sourceData.length)
            //创建Byte数组和各项指针
            let dataBytes = UnsafeMutableRawPointer.allocate(bytes: Int(dataSize), alignedTo: 0)
            var sourcePtr = unsafeBitCast(dataBytes, to: UnsafePointer<GLchar>.self)
            var sourcePtrPtr: UnsafePointer<UnsafePointer<GLchar>?>!
            withUnsafePointer(to: &sourcePtr, { ptr in
                sourcePtrPtr = unsafeBitCast(ptr, to: UnsafePointer<UnsafePointer<GLchar>?>.self)
            })
            //填充
            sourceData.getBytes(dataBytes, range: NSRange.init(location: 0, length: Int(dataSize)))
            glShaderSource(shaderHandle, 1, sourcePtrPtr, dataSize.pointer)
            free(dataBytes)
            glCompileShader(shaderHandle)
            var compiled: GLint = 0
            glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), compiled.pointer)
            if compiled == 0 {
                var infoLen: GLint = 0
                glGetShaderiv(shaderHandle, GLenum(GL_INFO_LOG_LENGTH), infoLen.pointer)
                if infoLen != 0 {
                    let logBuf = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(infoLen))
                    glGetShaderInfoLog(shaderHandle, GLsizei(infoLen), nil, logBuf)
                    let log = String.init(cString: logBuf)
                    print("GLE: \(log)")
                }
                glDeleteShader(shaderHandle)
                shaderHandle = 0
            } else {
                print("GLE: Shader build success!")
            }
        } else {
            print("GLE: Shader create failed!")
        }
        return shaderHandle;
    }
    
    static func gleBuildProgram(vertexHandle: GLuint, fragmentHandle: GLuint) -> GLuint {
        if vertexHandle == 0 || fragmentHandle == 0 {
            print("GLE: Shaders not ready!")
            return 0
        }
        var programHandle = glCreateProgram()
        if programHandle != 0 {
            glAttachShader(programHandle, vertexHandle)
            glAttachShader(programHandle, fragmentHandle)
            glLinkProgram(programHandle)
            var linkStatus: GLint = GL_FALSE
            glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), linkStatus.pointer)
            if linkStatus != GL_TRUE {
                var infoLen: GLint = 0
                glGetProgramiv(programHandle, GLenum(GL_INFO_LOG_LENGTH), infoLen.pointer)
                if infoLen != 0 {
                    let logBuf = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(infoLen))
                    glGetProgramInfoLog(programHandle, GLsizei(infoLen), nil, logBuf)
                    let log = String.init(cString: logBuf)
                    print("GLE: \(log)")
                }
                glDeleteProgram(programHandle)
                programHandle = 0
            } else {
                print("GLE: Program build success!")
            }
        } else {
            print("GLE: Program create faild!")
        }
        return programHandle
    }
}


