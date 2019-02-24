//
//  TabBar.swift
//  TestTabBar
//
//  Created by under on 31/01/2019.
//  Copyright © 2019 under. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class TabBar : UIView {
    
    //commentaire test
    
    // private let <= const
    private var container: UIViewController?
    private var position: Position?
    private var bgColor: UIColor?
    private var buttons = [UIButton]()
    private var numberButtons = [Int]()
    private var arrayButtonDeleted: [UIButton] = []
    private var tableView: UITableView!
    private var total = CGFloat()
    
    let screensizeWidth = UIScreen.main.bounds.width
    let screensizeHeight = UIScreen.main.bounds.height
    
    
    let colorPressed = UIColor(rgb: 0xD7BBC5)
    let colorNotPressed = UIColor(rgb: 0x235678)
    
    var buttonsColor: [UIButton] = [UIButton]()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(contentView)
    }
    
    let contentView: UIView = {
        let screensize = UIScreen.main.bounds
        
        let view = UIView()
       
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    public func setTabBarColor(color: UIColor) {
        contentView.backgroundColor = color
    }
   
    public func setContainer(container: UIViewController) {
        self.container = container
    }
    
    public func build() {
        // container must not be null to continue
        
        //definePosition(position: Position.LEFT)
        self.backgroundColor = .white

        /*defineButtons()
        
        for(button in buttons) {
            self.addSubview(button)
        }*/
        
    }
    public func definePosition(position: Position) -> Position {
        switch position {
        case .BOTTOM:
            contentView.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(CGSize(width: screensizeWidth, height: 50))
                make.left.right.equalTo(self)
                make.bottom.equalTo(self).offset(-20)
            }
        case .TOP:
            contentView.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(CGSize(width: screensizeWidth, height: 50))
                make.left.right.equalTo(self)
                make.top.equalTo(self).offset(60)
            }
        case .RIGHT:
            contentView.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(CGSize(width: 60, height: screensizeHeight))
                make.top.equalTo(self)
                make.bottom.equalTo(self)
                make.right.equalTo(self)
            }
        case .LEFT:
            contentView.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(CGSize(width: 60, height: screensizeHeight))
                make.top.equalTo(self)
                make.bottom.equalTo(self)
                make.left.equalTo(self)
            }
        //default:
          //  position = position.BOTTOM
        }
        return position
    }
    
    public func selectNumberOfButton(numberButton: Int) -> [UIButton] {
        for _ in 1...numberButton {
            buttons.append(UIButton())
        }
        return buttons
    }
    
    private func changePlaceButton() {
        guard let lastButton = self.buttons.last else {
            return;
        }
        let imageMore = UIImage(named: "more")
        let buttonMore: UIButton = UIButton()
        guard let frameButtonMore = self.buttons.last?.frame else { return }
        buttonMore.frame = frameButtonMore
        buttonMore.setImage(imageMore, for: .normal)
        buttonMore.addTarget(self, action:#selector(TabBar.buttonMore(_:)), for: .touchUpInside)
        self.buttons.removeLast()
        self.buttons.append(buttonMore)
        self.arrayButtonDeleted.insert(lastButton, at: 0)
        
        var total: CGFloat = 0.0
        
        for button in self.buttons {
            self.contentView.addSubview(button)
            total += button.frame.size.width
        }
    }

    
    private func setTableView() {
        tableView = UITableView(frame: CGRect(x: 150, y: 200, width: 150, height: 300))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        //myTableView.delegate = self
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        tableView.isHidden = true
        self.addSubview(tableView)
    }
    
    @objc public func buttonMore(_ sender:UIButton!)  {
        self.tableView.isHidden = !self.tableView.isHidden
    }

    public func isLandscape() -> Bool {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            return true
        } else {
            print("Portrait")
            return false
        }
    }
  
    
    public func chooseSizeButton(buttons: [UIButton], position: Position, sizeButtons: CGFloat...) {
        
        var total: CGFloat = 0.0
       
        var gap: CGFloat = 0.0
        var count: Int = 0
        var addBullshit: CGFloat = 0.0
        
        var buttonsToDelete = [UIButton]()
        
        if position == .BOTTOM || position == .TOP {
            for button in buttons {
                let previousButton = buttons.before(button)
                
                button.frame = CGRect(x: (previousButton?.frame.size.width ?? 0) + gap + addBullshit, y: 0, width: ceil(setButtonSizeWidth(buttonWidth: sizeButtons[count])), height: 50)
                
                total += ceil(setButtonSizeWidth(buttonWidth: sizeButtons[count]))
                
                gap = 0.1
                count += 1
                addBullshit += previousButton?.frame.size.width ?? 0

                for i in 0..<self.buttons.count{
                    
                    buttons[i].addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                    buttons[i].backgroundColor = colorNotPressed
                }
            
                
                if(isLandscape()) {
                    addButtonToTabBar(sizeTabBar: screensizeWidth, sizeButton: total)
                }
                
                contentView.addSubview(button)
            }
            
       } else if position == .RIGHT || position == .LEFT {
            for button in buttons {
                let previousButton = buttons.before(button)
             
                 button.frame = CGRect(x: 0, y: (previousButton?.frame.height ?? 30) + gap + addBullshit, width: 60, height: setButtonHeight(buttonHeight: sizeButtons[count]))
                
                total += ceil(setButtonHeight(buttonHeight: sizeButtons[count]))
                
                gap = 0.1
                count += 1
                addBullshit += previousButton?.frame.height ?? 30
                
                for i in 0..<self.buttons.count{
                    
                    buttons[i].addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                    buttons[i].backgroundColor = colorNotPressed
                }
                contentView.addSubview(button)
            }
        }
    }
    
    private func deleteImageFromImageView(imageView: UIImageView) {
        imageView.image = nil
    }
    
    public func addImageView(buttons: [UIButton], position: Position, icone: String...){
        var total: CGFloat = 0.0
        var count: Int = 0
        var addBullshit: CGFloat = 0.0
        
        var buttonsExceedTabBar = [UIButton]()
        
        var previousButton = UIButton()
        
        if position == .BOTTOM || position == .TOP {
            var gap: CGFloat = 0.0

            for button in buttons {
                let previous = buttons.before(button)
                
                let image = UIImage(named: icone[count])
                let imageView = UIImageView(image: image)
                imageView.image = image
              
                imageView.frame = CGRect(x: (previous?.frame.size.width ?? 0) + gap + addBullshit, y: 0, width: (image?.size.width)!, height: 50)
                
                gap += 0.1
                count += 1
                addBullshit += previous?.frame.size.width ?? 0
                
                setDefaultWidthFrame(imageView: imageView, button: button, image: image)
                button.addSubview(imageView)
   
            }
            
        } else if position == .LEFT || position == .RIGHT {
            for button in buttons {
                let image = UIImage(named: icone[count])
                let imageView = UIImageView(image: image)
                
                imageView.backgroundColor = .cyan
                imageView.image = image
                
                let halfImageHeight = (image?.size.height)! / 2
                let halfButtonHeight = button.frame.height / 2
                
                imageView.frame = CGRect(x: 0, y: halfButtonHeight - halfImageHeight, width: 60, height: (image?.size.height)!)
                
                count += 1
            
                setDefaultHeightFrame(imageView: imageView, button: button, image: image)
                
                total += ceil(button.frame.size.height)
                
                
                if(total > screensizeHeight) {
                    previousButton = buttons.before(button)!
                    
                    if(((total - previousButton.frame.height) + previousButton.frame.height) > screensizeHeight){
                    buttonsExceedTabBar.append(button)
                    buttonsExceedTabBar.append(previousButton)
                        
                        print(buttonsExceedTabBar.count)
                   // print("total - previousButton.frame.height ", total - previousButton.frame.height)

                   // buttonsExceedTabBar.append(previousButton)
                    
                    print("previous ", previousButton.frame.height)
                    
                    previousButton.imageView?.removeFromSuperview()
                    

                    
                    /*print("previousButton.frame.size.height ", previousButton)
                    
                     print("previousButton width ", previousButton.frame.width)
                    
                    print("previousButton height ", previousButton.frame.height)
                    
                    print("previous x ", previousButton.frame.maxX)
                    
                    print("previous y ", previousButton.frame.maxY)
                    
                    
                    
                    print("previousPreviousButton.frame.size.height ", previousPreviousButton as Any)
                    
                    print("previousPreviousButton width ", previousPreviousButton!.frame.width)
                    
                    print("previousPreviousButton height ", previousPreviousButton!.frame.height)
                    
                    print("previousPreviousButton x ", previousPreviousButton!.frame.maxX)
                    
                    print("previousPreviousButton y ", previousPreviousButton!.frame.maxY)*/
                    
                    //previousButton.frame = CGRect(x: 5, y: previousButton.frame.maxY + previousButton.frame.height - 10, width: previousButton.frame.width, height: previousButton.frame.height)
                    
                   // buttonMore = previousButton
                    
                   // previousButton.addSubview(imageView!)
                    //buttonMore.addSubview(imageView)
                    
                   // previousButton = buttonMore
                    
                    //button.addSubview(previousButton)
                    
                 
                   // print("nextButton?.frame.height ", nextButton?.frame.height)
                  //  print("nextButton?.frame.height + total ", (nextButton?.frame.height)! + total)
                    
                    //let imageView = UIImageView(image: UIImage(named: "more"))
                    
                    //previousButton.addSubview(imageView)
                    //contentView.addSubview(button)
                    }
                } else {
                    button.addSubview(imageView)

                }
                
            }
            
            print("TOTAL ", total)
        }
    }
    
        public func viewWillTransition(to: CGSize, with: UIViewControllerTransitionCoordinator) {
            //super.viewWillTransition(to: size, with: coordinator)
            if UIDevice.current.orientation.isLandscape {
                print("Landscape")
                
            } else {
                print("Portrait")
                
            }
        }
        
    private func checkButtonOnTabBar(buttons: [UIButton]) {
        let screenHeight = UIScreen.main.bounds.height
        
        print("buttons count : ", buttons.count)
        print("screen height : ", screenHeight)
        
        var total: CGFloat = 0.0
        for button in buttons {
            total += button.frame.size.height
        }
        
        print("button total height : ", total)
        
        if(total > screenHeight) {
            print("Too much button on tab bar")
        } else if (total < screenHeight) {
            print("Total button fit inside tab bar")
        }
        
    }
    
    private func setButtonSizeWidth(buttonWidth: CGFloat) -> CGFloat {
        return screensizeWidth * buttonWidth
    }
    
    private func setButtonHeight(buttonHeight: CGFloat) -> CGFloat {
        return screensizeHeight * buttonHeight
    }
    
    private func addButtonToTabBar(sizeTabBar: CGFloat, sizeButton: CGFloat) -> [UIButton] {
        var i: Int = 0
        print("size Button : ", sizeButton)
        print("size height : ", sizeTabBar)
        for button in buttons {
           // self.buttons[i].frame = CGRect(x: 0, y: 0, width: 100, height: 50)
           // sizeButton += self.buttons[i].frame.size.height
            if(sizeButton > sizeTabBar) {
                print("sizeButton > sizeTabBar")
                self.arrayButtonDeleted.append(button)
            
                print("arrayButton deleted : ", arrayButtonDeleted)
                
                if let index = self.buttons.index(of: button) {
                    self.buttons.remove(at: index)
                    i = index
                }
            } else {
                i += 1
            }
        }
        self.changePlaceButton()
        self.setTableView()
        return self.buttons
    }
    
    public func fixWidthButton(button: UIButton, width: CGFloat) {
        let imageButtonWidth = setButtonSize(buttonWidth: width)
        button.frame = CGRect(x: 0, y: 0, width:imageButtonWidth, height: 50)
    }
    
    private func setButtonSize(buttonWidth: CGFloat) -> CGFloat {
        let screensizeWidth = UIScreen.main.bounds.width
        
        return screensizeWidth * buttonWidth
    }
    
    public func setBackgroundColor(color: UIColor?) {
        self.bgColor = color
    }
    
    private func setDefaultWidthFrame(imageView: UIImageView, button: UIButton, image: UIImage?) {
        
        print("image View size : ", imageView.frame.size)
        print("button size : ", button.frame.size)
        
        if(imageView.frame.maxX > button.frame.size.width || imageView.frame.minX < 0) {
            imageView.frame = CGRect(x: 0, y: 0, width: button.frame.size.width, height: (image?.size.height)!)
            
            print("image view is not inside button, default value assigned")
        } else {
            print("image view size ok")
        }
    }
    
    private func setDefaultHeightFrame(imageView: UIImageView, button: UIButton, image: UIImage?) {
        if(imageView.frame.maxY > button.frame.size.height || imageView.frame.minY < 0) {
            imageView.frame = CGRect(x: 0, y: button.frame.size.height - 10, width: 60, height: (image?.size.height)!)
            
            print("image view is not inside button, default value assigned")
        } else {
            print("image view size ok")
        }
    }
    
    @objc func btnClick(_ sender: UIButton){
        let btn = sender
        var imageView: UIImageView? = nil
        var imageViewPrevious: UIImageView? = nil
        buttonsColor.append(btn)
        
        print(sender.isSelected)
        if(!sender.isSelected){
            UIView.beginAnimations("test", context: nil)
            UIView.setAnimationTransition(.none, for: self, cache: false)
            UIView.setAnimationDuration(0.1)
            btn.backgroundColor = self.colorPressed
            btn.subviews.forEach { img in
                imageView = img as! UIImageView
                imageView!.setImageColor(color: colorNotPressed)
            }
            //imageView = btn.subviews.first as! UIImageView
            UIView.commitAnimations()
            print("NOT SELECTED")
            btn.isSelected = true
            print(buttonsColor.count)
            if(buttonsColor.count > 1 && buttonsColor.count <= 2){
                let previousBtn = buttonsColor.first
                previousBtn?.backgroundColor = colorNotPressed
                previousBtn?.subviews.forEach { img in
                    imageViewPrevious = img as! UIImageView
                    imageViewPrevious!.setImageColor(color: UIColor.black)
                }
                previousBtn?.imageView?.setImageColor(color: UIColor.black)
                previousBtn?.isSelected = false
                buttonsColor.remove(at: 0)
            }
        } else {
            print("SELECTED")
        }
    }
}

extension BidirectionalCollection where Iterator.Element: Equatable {
    typealias Element = Self.Iterator.Element
    
    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.index(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop && firstItem {
                return self.last
            } else if firstItem {
                return nil
            } else {
                return self[index(before:itemIndex)]
            }
        }
        return nil
    }
    
    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.index(of: item) {
            let lastItem: Bool = (index(after:itemIndex) == endIndex)
            if loop && lastItem {
                return self.first
            } else if lastItem {
                return nil
            } else {
                return self[index(after:itemIndex)]
            }
        }
        return nil
    }
}

extension TabBar: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayButtonDeleted.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        if indexPath.row < self.arrayButtonDeleted.count {
            cell.contentView.addSubview(self.arrayButtonDeleted[indexPath.row])
        } else {
            print("no view at index")
        }
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0)
        return cell
    }
    
    
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

class CustomUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.blue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("touch start")
        backgroundColor = UIColor.red
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        print("touch ended")
        backgroundColor = UIColor.blue
        
    }
    
}
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}


