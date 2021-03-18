import UIKit
import WatchKit
import CoreFoundation

class Quatz2DController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    
    
    @IBAction func drawAction() {

        UIGraphicsBeginImageContext(CGSize(width: 120.0, height: 120.0))
        let ref = UIGraphicsGetCurrentContext()
        if let context = ref {
            context.beginPath()
            context.setLineWidth(3.0)
            context.setStrokeColor(UIColor.cyan.cgColor)
            context.setFillColor(UIColor.yellow.cgColor)
            context.setLineCap(.square)

            context.move(to: CGPoint(x: 20.0, y: 20.0))
            context.addLine(to: CGPoint(x: 40.0, y: 80.0))
            context.addLine(to: CGPoint(x: 60.0, y: 80.0))
            context.addLine(to: CGPoint(x: 80.0, y: 50.0))
            context.addLine(to: CGPoint(x: 100.0, y: 40.0))
            context.addLine(to: CGPoint(x: 120.0, y: 10.0))
            context.strokePath()
            
            UIGraphicsEndImageContext()
            let newImage = UIImage(cgImage: context.makeImage()!)
            image.setImage(newImage)
        }
    }
    
    @IBAction func drawPathAction() {
        
        UIGraphicsBeginImageContext(CGSize(width: 120.0, height: 120.0))
        let ref = UIGraphicsGetCurrentContext()
        if let context = ref {
            context.beginPath()
            context.setStrokeColor(UIColor.cyan.cgColor)
            context.setFillColor(UIColor.yellow.cgColor)

            let path = UIBezierPath(arcCenter: CGPoint(x: 60.0, y: 60.0), radius: 40.0, startAngle: CGFloat.pi / 3, endAngle: CGFloat.pi / 2, clockwise: false)
            path.lineCapStyle = .round
            path.lineWidth = 2.0
            path.stroke()
            path.fill()
            
            UIGraphicsEndImageContext()
            let newImage = UIImage(cgImage: context.makeImage()!)
            image.setImage(newImage)
        }
    }
}
