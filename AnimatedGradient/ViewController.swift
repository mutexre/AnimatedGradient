//
//  Created by Alexander Obuschenko on 31/10/2017.
//  Copyright © 2017 mutexre. All rights reserved.
//

import UIKit

class GradientView : UIView, CAAnimationDelegate
{
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
 
    @IBInspectable var duration: Double = 1.0
    
    @IBInspectable var color1: UIColor = UIColor(red: 48/255, green: 62/255, blue: 103/255, alpha: 1) {
        didSet {
            cgColor1 = color1.cgColor
        }
    }
    
    @IBInspectable var color2: UIColor = UIColor(red: 244/255, green: 88/255, blue: 53/255, alpha: 1) {
        didSet {
            cgColor2 = color2.cgColor
        }
    }
    
    @IBInspectable var color3: UIColor = UIColor(red: 196/255, green: 70/255, blue: 107/255, alpha: 1) {
        didSet {
            cgColor3 = color3.cgColor
        }
    }
    
    private var cgColor1: CGColor!
    private var cgColor2: CGColor!
    private var cgColor3: CGColor!
    
    override func awakeFromNib()
    {
        gradient.frame = bounds
        gradient.colors = [ cgColor1, cgColor2 ]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        layer.insertSublayer(gradient, at: 0)
        
        animate()
    }
    
    func animate()
    {
        let animation1 = CABasicAnimation(keyPath: "colors")
        animation1.beginTime = 0
        animation1.duration = duration
        animation1.fromValue = [ cgColor1, cgColor2 ]
        animation1.toValue = [ cgColor2, cgColor3 ]
        
        let animation2 = CABasicAnimation(keyPath: "colors")
        animation2.beginTime = duration
        animation2.duration = duration
        animation2.fromValue = [ cgColor2, cgColor3 ]
        animation2.toValue = [ cgColor3, cgColor1 ]
        
        let animation3 = CABasicAnimation(keyPath: "colors")
        animation3.beginTime = 2 * duration
        animation3.duration = duration
        animation3.fromValue = [ cgColor3, cgColor1 ]
        animation3.toValue = [ cgColor1, cgColor2 ]
        
        let group = CAAnimationGroup()
        group.animations = [ animation1, animation2, animation3 ]
        group.duration = 3 * duration
        group.repeatCount = .infinity
        group.isRemovedOnCompletion = false
        gradient.add(group, forKey: "colorChange")
    }
    
    override func layoutSubviews() {
        gradient.frame = bounds
    }
}

class ViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
