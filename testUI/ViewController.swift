

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private func setShades(count: Int) {

            var previousSizes = 8
            var lastAddedView: UIView? = nil
        for imageURL in 0...count {
                let imageView = UIImageView()
                imageView.layer.borderWidth = 4
                imageView.layer.cornerRadius = 25
            
                imageView.clipsToBounds = true
                imageView.layer.borderColor = UIColor.black.cgColor
                imageView.isUserInteractionEnabled = true
                imageView.image = UIImage(named: "ggg")

                if let lastView = lastAddedView {
                    view.insertSubview(imageView, belowSubview: lastView)
                } else {
                    view.addSubview(imageView)
                }

                imageView.snp.makeConstraints { make in
                    make.trailing.equalToSuperview().inset(previousSizes)
                    make.bottom.equalTo(view.snp.bottom).inset(200)
                    make.size.equalTo(50)
                }

                previousSizes += 25
                lastAddedView = imageView
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()


        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        setShades(count: 3)


//        let circleSize: CGFloat = 100
//        let borderWidth: CGFloat = 4
//        let circleSpacing: CGFloat = 30
//
//        var previousCircleView: UIImageView?

//        for i in 0..<3 {
//            let circleImageView = UIImageView()
//            circleImageView.image = UIImage(named: "ggg")
//            circleImageView.contentMode = .scaleAspectFill
//            view.addSubview(circleImageView)
//
//            let maskLayer = CAShapeLayer()
//            let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: circleSize, height: circleSize))
//            let borderPath = UIBezierPath(ovalIn: CGRect(x: -borderWidth, y: -borderWidth, width: circleSize + 2 * borderWidth, height: circleSize + 2 * borderWidth))
//            borderPath.append(circlePath)
//            borderPath.usesEvenOddFillRule = true
//
//            maskLayer.path = borderPath.cgPath
//            maskLayer.fillRule = .evenOdd
//            circleImageView.layer.mask = maskLayer
//
//            circleImageView.snp.makeConstraints { make in
//                make.width.height.equalTo(circleSize + 2 * borderWidth)
//                make.centerY.equalToSuperview()
//
//                if let previous = previousCircleView {
//                    make.left.equalTo(previous.snp.right).offset(-(circleSize - circleSpacing + borderWidth))
//                } else {
//                    make.left.equalToSuperview().offset(20)
//                }
//            }
//
//            previousCircleView = circleImageView
//        }
    }
}


