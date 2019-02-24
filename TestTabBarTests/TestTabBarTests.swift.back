//
//  TestTabBarTests.swift
//  TestTabBarTests
//
//  Created by TDSV on 17/02/2019.
//  Copyright © 2019 TDSV. All rights reserved.
//

import XCTest
@testable import TestTabBar

class TestTabBarTests: XCTestCase {
    var taBbarViewController: TabBarViewController = TabBarViewController()
    var tabBar: TabBar { return taBbarViewController.view as! TabBar}
   
    func testOrientation() {
        let portrait = XCUIDevice.shared.orientation.isPortrait
        XCTAssertEqual(portrait, tabBar.isLandscape())
        XCUIDevice.shared.orientation = .landscapeLeft
        sleep(3)
        let landscape = XCUIDevice.shared.orientation.isLandscape
        XCTAssertNotEqual(landscape, tabBar.isLandscape())
    }
    func testPosition() {
        let positions: [Position] = [Position.BOTTOM, Position.LEFT, Position.TOP, Position.RIGHT]
        for i in 0..<positions.count {
            if(positions[i] == tabBar.definePosition(position: positions[i])) {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
        }
    }
    func testImgContent() {
        let bundle = Bundle.init(for: TestTabBarTests.self)
        let arrayImage: [String] = ["more", "search"]
        for image in arrayImage {
             let image = UIImage(named: image, in: bundle, compatibleWith: nil)
            guard  image != nil else {
                print("didn't find \(String(describing: image)) image in assets")
                XCTAssert(false)
                return
            }
        }
        XCTAssert(true)
    }
    func testButtonTabBar() {
        var buttons = tabBar.selectNumberOfButton(numberButton: 4)
        if(buttons.count == 1) {
            print("Error: number buttons must be above to 1")
            XCTFail()
        }
        let frameTB: CGFloat = tabBar.frame.size.width
        var sizeButton: CGFloat = 100
        var sizeTotalBtnTB: CGFloat = 0
        for i in 0..<buttons.count {
            buttons[i].frame.size.width = 100
            sizeButton += buttons[i].frame.size.width
            if(sizeButton < frameTB) {
                sizeTotalBtnTB = sizeButton
            }

        }
        XCTAssertLessThan(sizeTotalBtnTB, frameTB)
    }
}
