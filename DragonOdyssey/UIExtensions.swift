//
//  UIExtensions.swift
//  HarmLess
//
//  Created by Jared on 9/21/20.
//  Copyright © 2020 Wired Betterment. All rights reserved.
//

import UIKit

class UIExtensions: NSObject {

}

extension UIView
{
    func removeSubviews()
    {
        for subview in self.subviews
        {
            subview.removeFromSuperview()
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addDiamondMask(cornerRadius: CGFloat = 0)
    {
        layoutIfNeeded()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: bounds.minY + cornerRadius))
        path.addLine(to: CGPoint(x: bounds.maxX - cornerRadius, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - cornerRadius))
        path.addLine(to: CGPoint(x: bounds.minX + cornerRadius, y: bounds.midY))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = cornerRadius * 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        layer.mask = shapeLayer
    }
    //
    //    func parentTV() -> UITableView?
    //    {
    //        if var superView = self.superview
    //        {
    //            while superView is UITableView != true {
    //                if let superViewO = superView.superview
    //                {
    //                    superView = superViewO
    //                }
    //                else { break }
    //            }
    //
    //            if let parentTV = superView as? UITableView
    //            {
    //                return parentTV
    //            }
    //            return nil
    //        }
    //        return nil
    //    }
    
    //    func findViewControllerOf<T>(type: T.Type) -> UIViewController?
    //    {
    //        if var superView = self.superview
    //        {
    //            while superView is UITableView != true {
    //                if let superViewO = superView.superview
    //                {
    //                    superView = superViewO
    //                }
    //                else { break }
    //            }
    //
    //            if let parentTV = superView as? UITableView
    //            {
    //                return parentTV
    //            }
    //            return nil
    //        }
    //        return nil
    //    }
}

extension CALayer
{
    func removeSublayers()
    {
        guard let sublayers = self.sublayers else { return }
        for sublayer in sublayers
        {
            sublayer.removeFromSuperlayer()
        }
    }
    
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIImage
{
    func newImageWith(newSize: CGSize) -> UIImage?
    {
        let scale = min(size.width/newSize.width, size.height/newSize.height)
        
        let newSize = CGSize(width: size.width/scale, height: size.height/scale)
        let newOrigin = CGPoint(x: (newSize.width - newSize.width)/2, y: (newSize.height - newSize.height)/2)
        
        let thumbRect = CGRect(origin: newOrigin, size: newSize).integral
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        
        draw(in: thumbRect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
}

extension UICollectionViewCell
{
    func parentCV() -> UICollectionView?
    {
        if var superView = self.superview
        {
            while superView is UICollectionView != true {
                if let superViewO = superView.superview
                {
                    superView = superViewO
                }
                else { break }
            }
            
            if let parentCV = superView as? UICollectionView
            {
                return parentCV
            }
            return nil
        }
        return nil
    }
}

extension UITableViewCell
{
    func parentTV() -> UITableView?
    {
        if var superView = self.superview
        {
            while superView is UITableView != true {
                if let superViewO = superView.superview
                {
                    superView = superViewO
                }
                else { break }
            }
            
            if let parentTV = superView as? UITableView
            {
                return parentTV
            }
            return nil
        }
        return nil
    }
}

extension UITextView
{
    func resizeFontToFit()
    {
        let textViewSize = self.frame.size;
        let fixedWidth = textViewSize.width;
        let expectSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)));
        
        var expectFont = self.font;
        if (expectSize.height > textViewSize.height) {
            while (self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height)
            {
                expectFont = self.font!.withSize(self.font!.pointSize - 1)
                self.font = expectFont
            }
        }
        else {
            while (self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height < textViewSize.height)
            {
                expectFont = self.font;
                self.font = self.font!.withSize(self.font!.pointSize + 1)
            }
            self.font = expectFont;
        }
    }
}

extension UILabel
{
    var isTruncated: Bool
    {
        
        guard let labelText = text else
        {
            return false
        }
        
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font!],
            context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
    
    // Adjusts the font size to avoid long word to be wrapped
    // *** May need to set layoutIfNeeded on superView of UILabel before calling to calculate accurate size
    func fitToAvoidWordWrapping()
    {
        guard adjustsFontSizeToFitWidth else {
            return // Adjust font only if width fit is needed
        }
        guard let words = text?.components(separatedBy: " ") else {
            return // Get array of words separate by spaces
        }
        
        // I will need to find the largest word and its width in points
        var largestWord: NSString = ""
        var largestWordWidth: CGFloat = 0
        
        // Iterate over the words to find the largest one
        for word in words {
            // Get the width of the word given the actual font of the label
            let wordWidth = word.size(withAttributes: [.font: font!]).width
            
            // check if this word is the largest one
            if wordWidth > largestWordWidth {
                largestWordWidth = wordWidth
                largestWord = word as NSString
            }
        }
        
        // Now that I have the largest word, reduce the label's font size until it fits
        while largestWordWidth > bounds.width && font.pointSize > 1 {
            // Reduce font and update largest word's width
            font = font.withSize(font.pointSize - 1)
            largestWordWidth = largestWord.size(withAttributes: [.font: font!]).width
        }
    }
}

extension UIButton
{
    func tintColorFrom(hexValue: String)
    {
        guard let origImage = self.image(for: .normal) else { return }
        
        let tintedImage = origImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        self.setImage(tintedImage, for: .normal)
        
        self.tintColor = UIColor.from(hexValue: hexValue)
    }
    
    func tint(color: UIColor)
    {
        guard let origImage = self.image(for: .normal) else { return }
        
        let tintedImage = origImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        self.setImage(tintedImage, for: .normal)
        
        self.tintColor = color
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State)
    {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}

extension UIViewController{
    var isOnScreen: Bool{
        return self.isViewLoaded && view.window != nil
    }
}

extension UIPageViewController {
    
    var scrollView: UIScrollView? {
        
        return view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
    }
    
    func goToNextPage(animated: Bool = true, completion: (()->Void)? = nil)
    {
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        
        setViewControllers([nextViewController], direction: .forward, animated: animated) { (finished) in
            if completion != nil { completion!() }
        }
    }
    
    
    func goToPreviousPage(animated: Bool = true, completion: (()->Void)? = nil)
    {
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
        
        setViewControllers([previousViewController], direction: .reverse, animated: animated) { (finished) in
            if completion != nil { completion!() }
        }
    }
}
