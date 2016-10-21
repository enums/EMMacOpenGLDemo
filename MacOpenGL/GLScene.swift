//
//  GLScene.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

class GLScene {
    
    var texIDs = Array<GLuint>.init(repeating: 0, count: 10)
    var objs = Dictionary<String, GLDrawable>()
    
    init() {
        
    }
    
    @discardableResult
    func addObject(key: String, obj: GLDrawable) -> Bool {
        if objs[key] == nil {
            objs[key] = obj
            return true
        } else {
            return false
        }
    }
    
    @discardableResult
    func removeObject(key: String) -> Bool {
        if objs[key] != nil {
            objs[key] = nil
            return true
        } else {
            return false
        }
    }
    
}
