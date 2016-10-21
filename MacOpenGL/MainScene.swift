//
//  MainScene.swift
//  MacOpenGL
//
//  Created by 郑宇琦 on 2016/9/27.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

import Foundation
import OpenGL.GL

class MainScene: GLScene {
    
    
    func setObjs() {
        let cubeA = GLCube.init(pos: GLEV3.init(0, 0, 0),
                                dir: GLEV3.init(0, 0, 0),
                                size: GLEV3.init(2, 2, 2))
        let cubeAConfig = GLTexConfig.init(type: .RGB, texID: texIDs[0])
        let cubeAConfigList = Array<GLTexConfig>.init(repeating: cubeAConfig, count: 6)
        cubeA.setConfigList(list: cubeAConfigList)
        addObject(key: "cubeA", obj: cubeA)
        
        let cubeB = GLCube.init(pos: GLEV3.init(-2, 0, 0),
                                dir: GLEV3.init(0, 0, 0),
                                size: GLEV3.init(2, 2, 2))
        let cubeBConfig = GLTexConfig.init(type: .RGB, texID: texIDs[1])
        let cubeBConfigList = Array<GLTexConfig>.init(repeating: cubeBConfig, count: 6)
        cubeB.setConfigList(list: cubeBConfigList)
        addObject(key: "cubeB", obj: cubeB)
        
        let cubeC = GLCube.init(pos: GLEV3.init(2, 0, 0),
                                dir: GLEV3.init(0, 0, 0),
                                size: GLEV3.init(2, 2, 2))
        let cubeCConfig = GLTexConfig.init(type: .RGB, texID: texIDs[2])
        let cubeCConfigList = Array<GLTexConfig>.init(repeating: cubeCConfig, count: 6)
        cubeC.setConfigList(list: cubeCConfigList)
        addObject(key: "cubeC", obj: cubeC)
        
        let cubeD = GLCube.init(pos: GLEV3.init(0, 3, 0),
                                dir: GLEV3.init(0, 0, 0),
                                size: GLEV3.init(6, 4, 4))
        let cubeDConfig = GLTexConfig.init(type: .RGB, texID: texIDs[3])
        let cubeDConfigList = Array<GLTexConfig>.init(repeating: cubeDConfig, count: 6)
        cubeD.setConfigList(list: cubeDConfigList)
        addObject(key: "cubeD", obj: cubeD)
        
        let floor = GLSquare.init(pos: GLEV3.init(0, 0, 0),
                                  dir: GLEV3.init(0, 0, 0),
                                  size: GLEV3.init(100, 100, 0))
        let floorConfig = GLTexConfig.init(type: .RGB, texID: texIDs[4],
                                           texWidthRepeat: 5, texHeightRepeat: 5)
        floor.setConfig(config: floorConfig)
        addObject(key: "floor", obj: floor)
    }
    
}
