//
//  TabBar.swift
//  TestTabBar
//
//  Created by lukile on 31/01/2019.
//  Copyright © 2019 lukile. All rights reserved.
//
import Foundation
import UIKit
import SnapKit

public class TabBar : UIView {
    
    //private var container: UIViewController?
    private var position: Position?
    private var bgColor: UIColor?
    private var colorPressed: UIColor?
    private var colorNotPressed: UIColor?
    private var buttons = [UIButton]()
    private var buttonsExceedTabBar = [UIButton]()
    private var imageButtonExceed = [String]()
    private var tableView: UITableView!
    private var total = CGFloat()
    private var inputSearch: UITextField = UITextField()
    private var textInputSearch: String = ""
    public var tab = [UIButton]()
    
    let screensizeWidth = UIScreen.main.bounds.width
    let screensizeHeight = UIScreen.main.bounds.height
    
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
    
    public func setColorButton(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        colorNotPressed = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        return self.colorNotPressed!
    }
    
    public func setButtonColorPressed(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        colorPressed = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        return self.colorPressed!
    }
    
    
    /*public func setContainer(container: UIViewController) {
     self.container = container
     }*/
    
    
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
        }
        return position
    }
    
    public func selectNumberOfButton(numberButton: Int) -> [UIButton] {
        for _ in 1...numberButton {
            buttons.append(UIButton())
        }
        return buttons
    }
    
    private func setTableView(position: Position) {
        switch position {
        case .LEFT:
            tableView = UITableView(frame: CGRect(x: 60, y: Int(screensizeHeight - 315), width: 60, height: buttonsExceedTabBar.count * 50))
        case .RIGHT:
            tableView = UITableView(frame: CGRect(x: Int(screensizeWidth - 120), y: Int(screensizeHeight - 315), width: 60, height: buttonsExceedTabBar.count * 50))
        case .TOP:
            tableView = UITableView(frame: CGRect(x: Int(screensizeWidth - 60), y: 110, width: 60, height: buttonsExceedTabBar.count * 50))
        case .BOTTOM:
            tableView = UITableView(frame: CGRect(x: Int(screensizeWidth - 60), y: Int(screensizeHeight) - buttonsExceedTabBar.count * 50 - 60, width: 60, height: buttonsExceedTabBar.count * 50))
        }
        
        tableView.dataSource = self
        tableView.delegate = self
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
        var previousFrameSize: CGFloat = 0.0
        
        if position == .BOTTOM || position == .TOP {
            for button in buttons {
                let previousButton = buttons.before(button)
                
                button.frame = CGRect(x: (previousButton?.frame.size.width ?? 0) + gap + previousFrameSize, y: 0, width: ceil(setButtonSizeWidth(buttonWidth: sizeButtons[count])), height: 50)
                
                // total += ceil(setButtonSizeWidth(buttonWidth: sizeButtons[count]))
                
                gap = 0.1
                count += 1
                previousFrameSize += previousButton?.frame.size.width ?? 0
                
                for i in 0..<self.buttons.count{
                    
                    buttons[i].addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                    buttons[i].backgroundColor = colorNotPressed
                }
                
                contentView.addSubview(button)
            }
            
        } else if position == .RIGHT || position == .LEFT {
            for button in buttons {
                let previousButton = buttons.before(button)
                
                button.frame = CGRect(x: 0, y: (previousButton?.frame.height ?? 30) + gap + previousFrameSize, width: 60, height: setButtonHeight(buttonHeight: sizeButtons[count]))
                
                //total += ceil(setButtonHeight(buttonHeight: sizeButtons[count]))
                
                gap = 0.1
                count += 1
                previousFrameSize += previousButton?.frame.height ?? 30
                
                for i in 0..<self.buttons.count{
                    
                    buttons[i].addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                    buttons[i].backgroundColor = colorNotPressed
                }
                contentView.addSubview(button)
            }
        }
    }
    public func getTextInputSearch() -> String? {
        return self.inputSearch.text
    }
    
    @objc public func buttonSearch(_ sender:UIButton!)  {
        self.inputSearch.frame = CGRect(x: 150, y: 250, width: 150, height: 25)
        self.setRightImage(imageName: "search")
        self.inputSearch.borderBottom(textField: self.inputSearch)
        self.inputSearch.isHidden = !self.inputSearch.isHidden
        self.addSubview(self.inputSearch)
    }
    
    @objc func clickButtonSearchInput(tapGestureRecognizer: UITapGestureRecognizer) {
        print(self.inputSearch.text as Any)
        guard let textInput = self.inputSearch.text else {
            return
        }
        self.textInputSearch = textInput
    }
    
    private func setRightImage(imageName:String) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickButtonSearchInput(tapGestureRecognizer:)))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        self.inputSearch.rightView = imageView;
        self.inputSearch.rightViewMode = .always
    }
    
    public func addImageView(buttons: [UIButton], position: Position, icone: String...){
        var total: CGFloat = 0.0
        var count: Int = 0
        var previousFrame: CGFloat = 0.0
        
        if position == .BOTTOM || position == .TOP {
            var gap: CGFloat = 0.0
            
            var buttonMoreYet = false
            var onlyTwoButton = true
            
            for button in buttons {
                
                if(icone[count] == "search") {
                    button.addTarget(self, action: #selector(TabBar.buttonSearch(_:)), for: .touchUpInside)
                }
                
                let previous = buttons.before(button)
                
                let image = UIImage(named: icone[count])
                let imageView = UIImageView(image: image)
                
                let halfImageWidth = (image?.size.width)! / 2
                let halfButtonWidth = button.frame.width / 2
                
                
                imageView.image = image
                
                imageView.frame = CGRect(x: halfButtonWidth - halfImageWidth , y: 0, width: (image?.size.width)!, height: 50)
                
                gap += 0.1
                count += 1
                previousFrame += previous?.frame.size.width ?? 0
                
                total += ceil(button.frame.size.width)
                
                setDefaultWidthFrame(imageView: imageView, button: button, image: image)
                
                let nextButton = buttons.after(button)
                
                if(nextButton != nil) {
                    let nextNextButton = buttons.after(nextButton!)
                    if((nextNextButton) != nil) {
                        onlyTwoButton = false
                        let nextButtonWidth = ceil(CGFloat((nextButton?.frame.width)!))
                        let nextNextButtonWidth = ceil(CGFloat((nextNextButton?.frame.width)!))
                        
                        if((nextNextButtonWidth + total ) < screensizeWidth) {
                            button.addSubview(imageView)
                        }
                        
                        if ((nextNextButtonWidth + nextButtonWidth + total) > screensizeWidth) {
                            if(buttonMoreYet == false) {
                                let halfImageWidth = (image?.size.width)! / 2
                                let halfButtonWidth = nextNextButton!.frame.width / 2
                                
                                let image = UIImage(named: "more")
                                let imageView = UIImageView(image: image)
                                
                                imageView.frame = CGRect(x: halfButtonWidth - halfImageWidth, y: 0, width: (image?.size.width)!, height: 50)
                                
                                nextNextButton?.addTarget(self, action:#selector(TabBar.buttonMore(_:)), for: .touchUpInside)
                                
                                nextNextButton?.addSubview(imageView)
                                
                                buttonMoreYet = true
                            }
                            
                            buttonsExceedTabBar.append(nextButton!)
                            imageButtonExceed.append(icone.after(icone[count])!)
                            
                            self.setTableView(position: position)
                        }
                    }
                    if(onlyTwoButton) {
                        button.addSubview(imageView)
                    }
                    
                }else {
                    print("no button after")
                    button.addSubview(imageView)
                    break
                }
            }
            
        } else if position == .LEFT || position == .RIGHT {
            var buttonMoreYet = false
            var onlyTwoButton = true
            
            for button in buttons {
                
                if(icone[count] == "search") {
                    button.addTarget(self, action: #selector(TabBar.buttonSearch(_:)), for: .touchUpInside)
                    
                }
                
                let image = UIImage(named: icone[count])
                let imageView = UIImageView(image: image)
                
                imageView.image = image
                
                let halfImageHeight = (image?.size.height)! / 2
                let halfButtonHeight = button.frame.height / 2
                
                imageView.frame = CGRect(x: 0, y: halfButtonHeight - halfImageHeight, width: 60, height: (image?.size.height)!)
                
                count += 1
                
                //Unless since button more appears
                //setDefaultHeightFrame(imageView: imageView, button: button, image: image)
                
                total += ceil(button.frame.size.height)
                
                let nextButton = buttons.after(button)
                
                if(nextButton != nil) {
                    let nextNextButton = buttons.after(nextButton!)
                    
                    if((nextNextButton) != nil) {
                        onlyTwoButton = false
                        let nextButtonHeight = ceil(CGFloat((nextButton?.frame.height)!))
                        let nextNextButtonHeight = ceil(CGFloat((nextNextButton?.frame.height)!))
                        if((nextNextButtonHeight + total) < screensizeHeight) {
                            button.addSubview(imageView)
                        }
                        if ((nextNextButtonHeight + nextButtonHeight + total) > (screensizeHeight - 30)) {
                            
                            if(buttonMoreYet == false) {
                                let image = UIImage(named: "more")
                                let imageView = UIImageView(image: image)
                                let halfImageHeight = (image?.size.height)! / 2
                                let halfButtonHeight = nextNextButton!.frame.height / 2
                                
                                
                                imageView.frame = CGRect(x: 0, y: halfButtonHeight - halfImageHeight, width: 60, height: (image?.size.height)!)
                                
                                nextNextButton?.addTarget(self, action:#selector(TabBar.buttonMore(_:)), for: .touchUpInside)
                                
                                nextNextButton?.addSubview(imageView)
                                
                                nextNextButton?.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                                
                                buttonMoreYet = true
                            }
                            
                            buttonsExceedTabBar.append(nextButton!)
                            imageButtonExceed.append(icone.after(icone[count])!)
                            
                            self.setTableView(position: position)
                        }
                    }
                    if(onlyTwoButton) {
                        button.addSubview(imageView)
                    }
                    
                }else {
                    print("no button after")
                    button.addSubview(imageView)
                    break
                }
            }
            
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
    
    private func setButtonSizeWidth(buttonWidth: CGFloat) -> CGFloat {
        return screensizeWidth * buttonWidth
    }
    
    private func setButtonHeight(buttonHeight: CGFloat) -> CGFloat {
        return screensizeHeight * buttonHeight
    }
    
    public func setBackgroundColor(color: UIColor?) {
        self.bgColor = color
    }
    
    private func setDefaultWidthFrame(imageView: UIImageView, button: UIButton, image: UIImage?) {
        if(imageView.frame.maxX > button.frame.size.width || imageView.frame.minX < 0) {
            imageView.frame = CGRect(x: 0, y: 0, width: (button.frame.size.width) / 2, height: (image?.size.height)!)
            
            print("image view is not inside button, default value assigned")
        } else {
            print("image view size ok")
        }
    }
    
    /*private func setDefaultHeightFrame(imageView: UIImageView, button: UIButton, image: UIImage?) {
     if(imageView.frame.maxY > button.frame.size.height || imageView.frame.minY < 0) {
     imageView.frame = CGRect(x: 0, y: button.frame.size.height - 10, width: 60, height: (image?.size.height)!)
     
     print("image view is not inside button, default value assigned")
     } else {
     print("image view size ok")
     }
     }*/
    
    @objc func btnClick(_ sender: UIButton){
        let btn = sender
        var imageView: UIImageView? = nil
        var imageViewPrevious: UIImageView? = nil
        buttonsColor.append(btn)
        
        print(sender.isSelected)
        if(!sender.isSelected){
            //UIView.beginAnimations("test", context: nil)
            //UIView.setAnimationTransition(.none, for: self, cache: false)
            //UIView.setAnimationDuration(0.1)
            btn.backgroundColor = self.colorPressed
            btn.subviews.forEach { img in
                imageView = img as? UIImageView
                imageView!.setImageColor(color: colorNotPressed!)
            }
            //UIView.commitAnimations()
            btn.isSelected = true
            if(buttonsColor.count > 1 && buttonsColor.count <= 2){
                let previousBtn = buttonsColor.first
                previousBtn?.backgroundColor = colorNotPressed
                previousBtn?.subviews.forEach { img in
                    imageViewPrevious = img as? UIImageView
                    imageViewPrevious!.setImageColor(color: UIColor.black)
                }
                previousBtn?.imageView?.setImageColor(color: UIColor.black)
                previousBtn?.isSelected = false
                for i in 0..<buttonsColor.count {
                    if(buttonsColor.count > 1) {
                        buttonsColor.remove(at: i)
                    }
                }
                
            }
        } else {
            for i in 0..<buttonsColor.count {
                if(buttonsColor.count > 1) {
                    buttonsColor.remove(at: i)
                }
            }
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


extension TabBar: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonsExceedTabBar.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let imageButton = imageButtonExceed[indexPath.row]
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        cell = CustomCell(frame: CGRect(x: 0, y: 0, width: 50, height: 0), icone: imageButton)
        
        cell!.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        return cell!
    }
}

class CustomCell: UITableViewCell {
    var cellButton = UIButton()
    
    init(frame: CGRect, icone: String) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        let image = UIImage(named: icone)
        let imageView = UIImageView(image: image)
        imageView.image = image
        cellButton = UIButton(frame: CGRect(x: 5, y: 0, width: 50, height: 0))
        
        cellButton.addSubview(imageView)
        
        addSubview(cellButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UITextField {
    func borderBottom(textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: textField.frame.size.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
}
