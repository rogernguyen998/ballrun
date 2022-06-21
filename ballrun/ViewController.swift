//
//  ViewController.swift
//  ballrun
//
//  Created by Apple on 16/06/2022.
//

import UIKit

class ViewController: UIViewController {
    let containerView: UIView = {
    let view = UIView()
        view.backgroundColor = .clear
        return view
    } ()
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
        
    } ()
    
    let greenView: UIView = {
    let view = UIView ()
        view.backgroundColor = .green
        return view
    } ()
    
    var timerRotate: Timer!
    
    var rotateAngle: CGFloat = 0
    
    var leftRightTimer: Timer!
    var leftRight: Bool = true
    
    var goDownTimer: Timer!
    var downTime: CGFloat = 1
    
    var goUpTimer: Timer!
    var upTime: CGFloat = 2
    var upMove = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setupUI()
        leftRightMove()
        timerRotate = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
            self.rotateAngle += 1
            self.blackView.transform = CGAffineTransform(rotationAngle: -.pi * self.rotateAngle/360)
        })
        
        
    }
    
    func leftRightMove() {
      if leftRight == true {
          leftRightTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
              self.containerView.frame.origin.x += 0.5
              if self.containerView.frame.maxX >= self.view.frame.maxX {
                  self.leftRightTimer.invalidate()
                  self.leftRight = false
                  if self.upMove {
                      self.goUp()
                  } else {
                      self.goDown()
                  }
              }
          })
      } else {
          leftRightTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
              self.containerView.frame.origin.x -= 0.5
              if self.containerView.frame.minX <= self.view.frame.minX {
              
                  self.leftRightTimer.invalidate()
                  self.leftRight = true
                  if self.upMove {
                      self.goUp()
                  } else {
                      self.goDown()
                  }
              }
          })
      }
    }
    
    func goDown () {
        goDownTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
            self.containerView.frame.origin.y += 0.5
            if self.downTime > 0 {
                if self.containerView.frame.maxY >= (self.view.frame.maxY * self.downTime / 3 ) {
                    self.goDownTimer.invalidate()
                    self.downTime += 1
                    if self.downTime > 3 {
                        self.upMove = true
                        self.leftRightMove()
                        self.downTime = 1
                    } else {
                        self.leftRightMove()
                    }
                }
            }
        })
    }
    
    func goUp () {
        goDownTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { _ in
            self.containerView.frame.origin.y -= 0.5
            if self.upTime > 0 {
                if self.containerView.frame.maxY <= (self.view.frame.maxY * self.upTime / 3) {
                    self.upTime -= 1
                    self.goDownTimer.invalidate()
                    self.leftRightMove()
                }
            } else {
                if self.containerView.frame.minY <= self.view.frame.minY {
                    self.goDownTimer.invalidate()
                    self.upMove = false
                    self.upTime = 2
                    self.leftRightMove()
                }
            }
        })
    }
    
    func setupUI () {
        view.addSubview(containerView)
        containerView.frame = .init(x: 0, y: 0, width: 60, height: 60)
        
        containerView.addSubview(blackView)
        blackView.frame = containerView.bounds
        blackView.layer.cornerRadius = 30
        blackView.clipsToBounds = true
        
        blackView.addSubview(greenView)
        greenView.frame = .init(x: 0, y: 0, width: 20, height: 20)
    
    }


}

