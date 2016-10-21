//
//  GLView.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import Cocoa

class GLView: NSOpenGLView {
    
    weak var camera: GLCamera?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        camera?.glResize(width: dirtyRect.width, height: dirtyRect.height)
    }

}
