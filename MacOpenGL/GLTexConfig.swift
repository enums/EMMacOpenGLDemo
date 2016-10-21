//
//  GLTexConfig.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/26.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

enum GLTexType {
    case RGB
    case YUV
}

class GLTexConfig {
    var type: GLTexType!
    var texID: GLuint?
    var texWidthRepeat: Float!
    var texHeightRepeat: Float!
    var width: GLfloat?
    var height: GLfloat?
    var yuvIDs: Array<GLuint>?
    var yuvData: NSData?
    var alpha: Float!
    init(type: GLTexType, texID: GLuint? = nil,
         texWidthRepeat: Float? = 1, texHeightRepeat: Float? = 1,
         width: GLfloat? = nil, height: GLfloat? = nil, yuvIDs: Array<GLuint>? = nil, yuvData: NSData? = nil,
         alpha: Float = 1) {
        self.type = type
        self.texID = texID
        self.texWidthRepeat = texWidthRepeat
        self.texHeightRepeat = texHeightRepeat
        self.width = width
        self.height = height
        self.yuvIDs = yuvIDs
        self.yuvData = yuvData
        self.alpha = alpha
    }
}
