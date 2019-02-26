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
   
    /*func testOrientation() {
        let portrait = XCUIDevice.shared.orientation.isPortrait
        XCTAssertEqual(portrait, tabBar.isLandscape())
        self.waitUntilRotation(to: UIInterfaceOrientation.landscapeLeft)
        sleep(3)
        let landscape = XCUIDevice.shared.orientation.isLandscape
        XCTAssertEqual(landscape, tabBar.isLandscape())
    }*/
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
                print("didn't find the image in assets")
                XCTAssert(false)
                return
            }
        }
        XCTAssert(true)
    }
    func testButtonTabBar() {
        let buttons = tabBar.selectNumberOfButton(numberButton: 4)
        if(buttons.count == 4) {
          XCTAssert(true)
        } else {
            print("Error: number buttons must be equals to \(buttons.count)")
            XCTAssert(false)
        }
    }
}

/*public extension XCTestCase {
    public func waitUntilRotation(to orientation: UIInterfaceOrientation) {
        guard UIApplication.shared.statusBarOrientation != orientation else {
            return
        }
        UIDevice.current.setValue(orientation.rawValue, forKey:"orientation")
    }
}*/

