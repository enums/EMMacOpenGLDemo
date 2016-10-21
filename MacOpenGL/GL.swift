//
//  GL.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/25.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

extension GLuint {
    var pointer: UnsafeMutablePointer<GLuint> {
        mutating get {
            var pointer: UnsafeMutablePointer<GLuint>!
            withUnsafeMutablePointer(to: &self, { ptr in
                pointer = ptr
            })
            return pointer
        }
    }
}

extension GLint {
    var pointer: UnsafeMutablePointer<GLint> {
        mutating get {
            var pointer: UnsafeMutablePointer<GLint>!
            withUnsafeMutablePointer(to: &self, { ptr in
                pointer = ptr
            })
            return pointer
        }
    }
}
