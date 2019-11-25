
import UIKit

final class SettingsCustomView {
    
    static let shared = SettingsCustomView()
    private init () {}
    
    var customImageFor: UIImageView {
        let image = UIImage(named: "birthdayTableView")
        let imageView = UIImageView(image: image)
        imageView.alpha = 0.3
        imageView.contentMode = .scaleAspectFit
        print(Thread.current)
        return imageView
    }
}
