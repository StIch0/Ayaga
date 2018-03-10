//
//  ViewBuild.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 01/02/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
protocol ViewBuild : NSObjectProtocol {
    func setData(data: [ViewData])
    func setEmptyData()
    func startLoading()
    func finishLoading()
}
