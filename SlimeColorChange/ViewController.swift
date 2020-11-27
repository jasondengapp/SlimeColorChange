//
//  ViewController.swift
//  SlimeColorChange
//
//  Created by Jason Deng on 2020/11/25.
//

import UIKit

class ViewController: UIViewController {
    let bodyGradientLayer = CAGradientLayer()
    
    @IBOutlet weak var shadowUIView: UIView!
    
    @IBOutlet weak var slimeUIImageView: UIImageView!
    
    // 外型Slider開關
    @IBOutlet weak var shapeUISwitch: UISwitch!
    @IBOutlet weak var shadowUISwitch: UISwitch!
    @IBOutlet weak var borderUISwitch: UISwitch!
    
    // 顏色Slider開關
    
    @IBOutlet weak var redUISwitch: UISwitch!
    @IBOutlet weak var alphaUISwitch: UISwitch!
    @IBOutlet weak var blueUISwitch: UISwitch!
    @IBOutlet weak var greenUISwitch: UISwitch!
    
    // 外型Slider
    @IBOutlet weak var shapeUISlider: UISlider!
    @IBOutlet weak var shadowUISlider: UISlider!
    @IBOutlet weak var borderUISlider: UISlider!
    
    // 顏色Slider
    @IBOutlet weak var bodyRedUISlider: UISlider!
    @IBOutlet weak var bodyBlueUISlider: UISlider!
    @IBOutlet weak var bodyGreenUISlider: UISlider!
    @IBOutlet weak var bodyAlphaUISlider: UISlider!
   
    
    
    @IBOutlet weak var randomUIButton: UIButton!
    @IBOutlet weak var defaultButton: UIButton!
    
    @IBOutlet weak var bodyColorUIButton: UIButton!
    
    @IBOutlet weak var mouthColorUIButton: UIButton!
    
    @IBOutlet weak var alphaUILabel: UILabel!
    @IBOutlet weak var blueUILabel: UILabel!
    @IBOutlet weak var greenUILabel: UILabel!
    @IBOutlet weak var redUILabel: UILabel!
    
    @IBOutlet weak var slimeBodyView: UIView!
    @IBOutlet weak var slimeMouthView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 載入無顏色身體圖片
        let bodyImgV = UIImageView(image: UIImage(named: "slimeBody"))
        // 載入無顏色嘴巴圖片
        let mouthImgV = UIImageView(image: UIImage(named: "slimeMouth"))
        
        bodyImgV.frame = slimeBodyView.bounds
        mouthImgV.frame = slimeMouthView.bounds
        bodyImgV.contentMode = .scaleAspectFill
        mouthImgV.contentMode = .scaleAspectFill
        
        slimeBodyView.mask = bodyImgV
        slimeMouthView.mask = mouthImgV
    }

    @IBAction func switchButtonClick(_ sender: Any) {
        
        if shadowUISwitch.isOn {
            shadowUISlider.isEnabled = true
        } else {
            shadowUISlider.isEnabled = false
        }
        
        if shapeUISwitch.isOn {
            shapeUISlider.isEnabled = true
        } else {
            shapeUISlider.isEnabled = false
        }
        
        if borderUISwitch.isOn {
            borderUISlider.isEnabled = true
        } else {
            borderUISlider.isEnabled = false
        }
        
        if redUISwitch.isOn {
            bodyRedUISlider.isEnabled = true
        } else {
            bodyRedUISlider.isEnabled = false
        }
        
        if greenUISwitch.isOn {
            bodyGreenUISlider.isEnabled = true
        } else {
            bodyGreenUISlider.isEnabled = false
        }
        
        if blueUISwitch.isOn {
            bodyBlueUISlider.isEnabled = true
        } else {
            bodyBlueUISlider.isEnabled = false
        }
        
        if alphaUISwitch.isOn {
            bodyAlphaUISlider.isEnabled = true
        } else {
            bodyAlphaUISlider.isEnabled = false
        }
    }
    
    @IBAction func SliderChange(_ sender: UISlider) {
        switch sender {
        
        case bodyRedUISlider, bodyGreenUISlider,bodyBlueUISlider,bodyAlphaUISlider:
            let red = bodyRedUISlider.value
            let green = bodyGreenUISlider.value
            let blue = bodyBlueUISlider.value
            let alpha = bodyAlphaUISlider.value
            redUILabel.text = String(format: "%3.0f", red)
            greenUILabel.text = String(format: "%3.0f", green)
            blueUILabel.text = String(format: "%3.0f", blue)
            alphaUILabel.text = String(format: "%.1f", alpha)
            
            slimeBodyView.backgroundColor = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: CGFloat(alpha))
            
        case borderUISlider:
           
            slimeUIImageView.layer.borderWidth = CGFloat(borderUISlider.value)
            
        case shapeUISlider:
            let redius = CGFloat(shapeUISlider.value)
            //slimeUIImageView.clipsToBounds = true
            slimeUIImageView.layer.cornerRadius = redius
            shadowUIView.layer.cornerRadius = redius
            
        case shadowUISlider:
            shadowUIView.layer.shadowOffset = CGSize(width: 10, height: 10)
            shadowUIView.layer.shadowOpacity = shadowUISlider.value
        default:
            break
        }
        
    }
    
    @IBAction func colorSelect(_ sender: UIButton) {
        
        switch sender {
        
        case randomUIButton:
            bodyGradientLayer.removeFromSuperlayer()
            let bodyColor = getRandomUIColor()
            let mouthColor = getRandomUIColor()
            let borderColor = getRandomUIColor()
            // change slider position
            bodyRedUISlider.value = bodyColor[0]*255
            bodyGreenUISlider.value = bodyColor[1]*255
            bodyBlueUISlider.value = bodyColor[2]*255
            bodyAlphaUISlider.value = bodyColor[3]
            shapeUISlider.value = Float.random(in: 30...100)
            shadowUISlider.value = Float.random(in: 0...1)
            borderUISlider.value = Float.random(in: 0...15)
            
            // change Slider Text
            redUILabel.text = String(format: "%3.0f", bodyRedUISlider.value)
            greenUILabel.text = String(format: "%3.0f", bodyGreenUISlider.value)
            blueUILabel.text = String(format: "%3.0f", bodyBlueUISlider.value)
            alphaUILabel.text = String(format: "%0.1f", bodyAlphaUISlider.value)
            
             //change body color
            slimeBodyView.backgroundColor =
                color2CGFloat(color: bodyColor)
//
//             change mouth color
            
            slimeMouthView.backgroundColor = color2CGFloat(color: mouthColor)
            
            // change shape, shadow, border
            slimeUIImageView.layer.cornerRadius = CGFloat(shapeUISlider.value)
            shadowUIView.layer.cornerRadius = CGFloat(shapeUISlider.value)
            shadowUIView.layer.shadowOffset = CGSize(width: 10, height: 10)
            shadowUIView.layer.shadowOpacity = shadowUISlider.value
            slimeUIImageView.layer.borderColor =  UIColor(red: CGFloat(borderColor[0]), green: CGFloat(borderColor[1]), blue: CGFloat(borderColor[2]), alpha: CGFloat(Float.random(in: 0.5...1))).cgColor
            slimeUIImageView.layer.borderWidth = CGFloat(borderUISlider.value)
        
        case bodyColorUIButton:
            slimeBodyView.alpha = 1
            bodyGradientLayer.frame = slimeBodyView.bounds
            bodyGradientLayer.colors = [color2CGFloat(color: getRandomUIColor()).cgColor, color2CGFloat(color: getRandomUIColor()).cgColor,color2CGFloat(color: getRandomUIColor()).cgColor, color2CGFloat(color: getRandomUIColor()).cgColor]
            slimeBodyView.layer.addSublayer(bodyGradientLayer)

        case mouthColorUIButton:
            slimeMouthView.backgroundColor = color2CGFloat(color: getRandomUIColor())
            
        case defaultButton:
//            bodyGradientLayer.removeFromSuperlayer()
            slimeBodyView.backgroundColor = UIColor.clear
            slimeMouthView.backgroundColor = UIColor.clear
            borderUISlider.value = 0
            shapeUISlider.value = 0
            shadowUISlider.value = 0
            bodyRedUISlider.value = 0
            bodyGreenUISlider.value = 0
            bodyBlueUISlider.value = 0
            bodyAlphaUISlider.value = 0
            slimeUIImageView.layer.borderWidth = 0
            slimeUIImageView.layer.cornerRadius = 0
            shadowUIView.layer.shadowOpacity = 0
            shadowUIView.layer.cornerRadius = 0
            redUILabel.text = "0"
            blueUILabel.text = "0"
            greenUILabel.text = "0"
            alphaUILabel.text = "0"

        default:
            break
        }
    }
    
    func getRandomUIColor() -> [Float] {
        return [Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1)]
    }
    
    func color2CGFloat(color: [Float]) -> UIColor{
        return UIColor(red: CGFloat(color[0]), green: CGFloat(color[1]), blue: CGFloat(color[2]), alpha: CGFloat(color[3]))
        
    }
    
}

