//
//  Categories.swift
//  SupremeEmotions
//
//   Created by anand singh on 06/03/21
//


import UIKit
import Foundation
import AVFoundation
import Kingfisher

//MARK: -UIViewController
extension UIViewController {
    func showAlert(title:String?,msg:String,onDismiss:(()->Void)!) {
        let alertControler = UIAlertController.init(title:title, message: msg, preferredStyle:.alert)
        alertControler.addAction(UIAlertAction.init(title:"OK", style:.destructive, handler: { (action) in
            onDismiss()
        }))
        self.present(alertControler,animated:true, completion:nil)
    }
}

//MARK: -UIView
extension UIView {
        
    func roundViewTopEdges(radius : CGFloat) {
        //        self.layer.masksToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
        }
    }
    
    func roundViewBottomEdges(radius : CGFloat) {
        //        self.layer.masksToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
        }
    }
    
    func roundCorners(corners : UIRectCorner, radius : CGFloat) {
        let rect = self.bounds
        let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        
        self.layer.mask = maskLayer
    }
    
    func addRoundedViewCorners(width:CGFloat,colorBorder: UIColor) {
        layer.cornerRadius = width
        layer.borderWidth = 1.0
        layer.borderColor = colorBorder.cgColor
        layer.masksToBounds = true
    }
    
    func addRoundedViewCorners() {
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    func addShadowOnCell() {
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSize.init(width:2, height:2)
        layer.masksToBounds = false;
    }
    
    func addShadow() {
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize.init(width:0, height:2)
    }
    
    func addShadowOffset(_ ofset: CGSize) {
        if self.tag == 999 { return } else { self.tag = 999 }
        layer.masksToBounds = false
        layer.shadowOffset = ofset
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.withHex(hex: "192d40", alpha: 1.0).cgColor
    }
    
    func addDropShadow() { //Used
        layer.masksToBounds = false
        layer.shadowOffset = CGSize.init(width:0, height:0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.withHex(hex: "000000", alpha: 0.25).cgColor
    }
    
    func springPopAnimation() {
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    
    func rippleEffect(darker:Bool) {
        let origin = CGPoint.init(x: self.bounds.width*0.5, y: self.bounds.height*0.5)
        let color = (darker == true) ? self.backgroundColor?.darker(by:25) : self.backgroundColor?.lighter(by: 25)
        let duration = 0.33
        let fadeDelay = 0.75*duration
        let radius = (self.bounds.size.width > self.bounds.size.height) ? self.bounds.size.width*2 : self.bounds.size.height*2
        
        rippleEffect(origin: origin, color: color!, duration: duration, radius: radius, fadeDelay: fadeDelay)
    }
    
    func rippleEffect(color:UIColor) {
        let origin = CGPoint.init(x: self.bounds.width*0.5, y: self.bounds.height*0.5)
        let duration = 0.33
        let fadeDelay = 0.75*duration
        let radius = (self.bounds.size.width > self.bounds.size.height) ? self.bounds.size.width*2 : self.bounds.size.height*2
        
        rippleEffect(origin: origin, color: color, duration: duration, radius: radius, fadeDelay: fadeDelay)
    }
    
    func rippleEffect(origin:CGPoint,color:UIColor, duration:TimeInterval,radius:CGFloat,fadeDelay:TimeInterval) {
        let angleFull = Double.pi*2
        let layerName = "ripple"
        
        let bounds = self.bounds
        let x = bounds.width
        let y = bounds.height
        
        // Build an array with the four corners of the view.
        let corners = [CGPoint.init(x: 0, y: 0),
                       CGPoint.init(x: 0, y: y),
                       CGPoint.init(x: x, y: 0),
                       CGPoint.init(x: x, y: y)]
        // Calculate the corner closest to the origin and the one farther from it.
        // We might not need these values, but calculate them anyway so that the code
        // is clearer.
        var minDistance = CGFloat.greatestFiniteMagnitude; var maxDistance = CGFloat(-1);
        for cornerValue in corners {
            let distance = origin.distance(cornerValue)
            if distance < minDistance {
                minDistance = distance
            }
            if distance > maxDistance {
                maxDistance = distance
            }
        }
        
        // Calculate the start and end radius of our ripple effect.
        // If the ripple starts inside the view then the start radis is 0, if it
        // starts outside the view then make the radius the distance to the nearest corner.
        let originInside = origin.x > 0 && origin.x < x && origin.y > 0 && origin.y < y
        // Note that if 0 is used as a default value then the circle may look misshapen.
        let startRadius = (originInside == true) ? 0.1 : minDistance
        
        // If we set a radius use it, if not then use the distance to the farthest corner.
        let endRadius = (radius > 0) ? radius : minDistance
        
        // Create paths for out start and end circles.
        let startPath = UIBezierPath.init(arcCenter: origin, radius: startRadius, startAngle: 0, endAngle: CGFloat(angleFull), clockwise: true)
        let endPath = UIBezierPath.init(arcCenter: origin, radius: endRadius, startAngle: 0, endAngle: CGFloat(angleFull), clockwise: true)
        
        // Create a new layer to draw the ripple on.
        let rippleLayer = CAShapeLayer()
        rippleLayer.name = layerName
        self.layer.masksToBounds = true
        rippleLayer.fillColor = color.cgColor
        
        // Create the animation
        let rippleAnimation = CABasicAnimation.init(keyPath: "path")
        rippleAnimation.fillMode = CAMediaTimingFillMode.both
        rippleAnimation.duration = duration
        rippleAnimation.fromValue = startPath.cgPath
        rippleAnimation.toValue = endPath.cgPath
        rippleAnimation.isRemovedOnCompletion = false
        rippleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        // Set the ripple layer to be just above the bg.
        self.layer.insertSublayer(rippleLayer, at: 0)
        // Give the ripple layer the animation.
        rippleLayer.add(rippleAnimation, forKey: nil)
        
        // Enqueue blocks to handle animation ends.
        // We can use a delegate for this, but it complicates the code as handling
        // animation states is needed as well as @propertys to pass data around.
        // This may not be perfectly times but it is good enough.
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeDelay) {
            let fadeAnimation = CABasicAnimation.init(keyPath: "opacity")
            fadeAnimation.fillMode = CAMediaTimingFillMode.both;
            fadeAnimation.duration = fadeDelay;
            fadeAnimation.fromValue = 1.0
            fadeAnimation.toValue = 0.0
            fadeAnimation.isRemovedOnCompletion = false
            rippleLayer.add(fadeAnimation, forKey: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeDelay) {
            rippleLayer.removeAllAnimations()
            rippleLayer.removeFromSuperlayer()
        }
    }
    
    func addBlurEffectToView(_ view: UIView) {
        let blurEffect = UIBlurEffect.init(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect);
        blurredEffectView.backgroundColor = UIColor.clear;        blurredEffectView.frame = view.bounds;       view.addSubview(blurredEffectView);        view.sendSubviewToBack(blurredEffectView)
        
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
    func showLoadingIndicator() {
        ProgressIndicator.shared().show( at: self)
    }
    
    func hideLoadingIndicator () {
        if let indicator:ProgressIndicator = self.viewWithTag(19518) as? ProgressIndicator {
            indicator.hide()
        }
    }

}


//MARK: -CALayer
extension CALayer {
    
    @IBInspectable var uiBorderColor:UIColor? {
        set {
            borderColor = newValue?.cgColor
        }
        get {
            return UIColor(cgColor: borderColor!)
        }
    }
}

//MARK: -UIImageView
extension UIImageView {
    func setImage(with urlString: String) {
          guard let url = URL.init(string: urlString) else {
              return
          }
          let resource = ImageResource(downloadURL: url, cacheKey: urlString)
          var kf = self.kf
          kf.indicatorType = .activity
          self.kf.setImage(with: resource)
      }
    
    func setRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true;
    }
    
    func addShadowOnImage() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        //0.7
        //self.layer.shouldRasterize = true
        self.layer.masksToBounds = false;
    }
    
     func loadImageFromUrl(strUrl : String, imgPlaceHolder : String) {
            self.kf.setImage(with: URL.init(string: strUrl), options: [.transition(.fade(0.15))]) { result in
                switch result {
                case .success( _):
                    break
                case .failure(let error):
                    print(error)
                    self.image = UIImage.init(named: imgPlaceHolder)
                }
            }
        }
}

//MARK: Gradient Type
@objc enum GradientStyle : Int {
    
    case leftToRight
    
    case radial
    
    case topToBottom
    
    case diagonal
    
}

//MARK: -UIColor
extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage))
    }
    
    /// Adjusts a colour by a `percentage`.
    ///
    /// Lightening → positive percentage
    ///
    /// Darkening → negative percentage
    func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0
        var white:CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        }
        else if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: min(hue + percentage/100, 1.0),
                           saturation: min(saturation + percentage/100, 1.0),
                           brightness: min(brightness + percentage/100, 1.0),
                           alpha: alpha)
        }
        else if self.getWhite(&white, alpha: &alpha) {
            return UIColor.init(white:min(white + percentage/100, 1.0), alpha: alpha)
        }
        else {
            return UIColor.init(white: 0.2, alpha: 0.6)
        }
    }
    
    class func withHex(hex:String,alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in:.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // Gradient color with Hex codes and specific style Frame Dependant
    class func gradient(style:GradientStyle,frame:CGRect,hexColors:[String]) -> UIColor {
        if hexColors.count == 0 {
            return Constant.AppColor.colorAppTheme
        }
        else {
            var cgColors = [CGColor]()
            hexColors.forEach({ (hexCode) in
                cgColors.append(withHex(hex: hexCode, alpha: 1.0).cgColor)
            })
            return gradient(style: style, frame: frame, colors: cgColors)
        }
    }
    
    // Gradient color with Hex codes & alpha and specific style Frame Dependant
    class func gradient(style:GradientStyle,frame:CGRect,hexColors:[String],alpha:CGFloat) -> UIColor {
        if hexColors.count == 0 {
            return Constant.AppColor.colorAppTheme
        }
        else {
            var cgColors = [CGColor]()
            hexColors.forEach({ (hexCode) in
                cgColors.append(withHex(hex: hexCode, alpha: alpha).cgColor)
            })
            return gradient(style: style, frame: frame, colors: cgColors)
        }
    }
    
    // Gradient color with radial style Frame InDependant
    class func gradient(frame:CGRect,colors:[CGColor]) -> UIColor {
        return gradient(style:.radial, frame:frame, colors: colors)
    }
    
    // Gradient color with radial style and HexColors Frame InDependant
    class func gradient(frame:CGRect,hexColors:[String]) -> UIColor {
        if hexColors.count == 0 {
            return Constant.AppColor.colorAppTheme
        }
        else {
            var cgColors = [CGColor]()
            hexColors.forEach({ (hexCode) in
                cgColors.append(withHex(hex: hexCode, alpha: 1.0).cgColor)
            })
            return gradient(style:.radial, frame: frame, colors: cgColors)
        }
    }
    
    // Gradient color with specific style and CGColors Frame Dependant
    class func gradient(style:GradientStyle,frame:CGRect,colors:[CGColor]) -> UIColor {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        
        if style == .leftToRight || style == .topToBottom {
            gradientLayer.colors = colors
            if style == .leftToRight {
                gradientLayer.startPoint = CGPoint.init(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0.5)
            }
            
            UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, UIScreen.main.scale)
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return UIColor.init(patternImage: gradientImage!)
        }
        else if style == .diagonal {
            gradientLayer.colors = colors
            gradientLayer.startPoint = CGPoint.init(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint.init(x: 0.0, y: 1.0)
            
            UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, UIScreen.main.scale)
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return UIColor.init(patternImage: gradientImage!)
        }
        else {
            UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
            let locations:[CGFloat] = [0.0,1.0]
            
            //Default to the RGB Colorspace
            let myColorspace = CGColorSpaceCreateDeviceRGB()
            let arrayRef:CFArray = colors as CFArray
            
            //Create our Gradient
            let gradient = CGGradient.init(colorsSpace:myColorspace, colors: arrayRef, locations: locations);
            
            // Normalise the 0-1 ranged inputs to the width of the image
            let centerPoint = CGPoint.init(x: frame.size.width*0.5, y: frame.size.height*0.5)
            let radius = min(frame.size.width, frame.size.height)*1.0
            
            // Draw our Gradient
            UIGraphicsGetCurrentContext()?.drawRadialGradient(gradient!, startCenter:centerPoint, startRadius:0, endCenter: centerPoint, endRadius: radius, options: .drawsAfterEndLocation)
            
            let gradientImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext()
            
            return UIColor.init(patternImage: gradientImage!)
        }
    }
}

//MARK: CGPoint
extension CGPoint {
    
    func distance(_ point: CGPoint) -> CGFloat {
        let xDist = self.x - point.x
        let yDist = self.y - point.y
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}

// ----------------------------------
// MARK: - Convenience -
//
public extension UITableView {
    func register<C>(_ cellType: C.Type) where C: UITableViewCell {
        let name = String(describing: cellType.self)
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func deque<C>(_ cellType: C.Type, at indexPath: IndexPath) -> C where  C: UITableViewCell{
        let name = String(describing: cellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: name, for: indexPath) as! C
        return cell
    }
}

//MARK: UIStoryboard
extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>() -> T {
        
        let viewController = self.instantiateViewController(withIdentifier: T.className)
        guard let typedViewController = viewController as? T else {
            fatalError("Unable to cast view controller of type (\(type(of: viewController))) to (\(T.className))")
        }
        return typedViewController
    }
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}


