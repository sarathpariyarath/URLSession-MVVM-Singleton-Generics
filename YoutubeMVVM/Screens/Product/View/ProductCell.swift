//
//  ProductCell.swift
//  YoutubeMVVM
//
//  Created by Sarath P on 17/02/23.
//

import UIKit


class ProductCell: UITableViewCell {
    
    
    @IBOutlet weak var vwProductBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnRate: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product? { //Property Observer
        didSet {
            configureProduct()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwProductBackground.clipsToBounds = false
        vwProductBackground.layer.cornerRadius = 15
        productImageView.layer.cornerRadius = 10
        self.vwProductBackground.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureProduct() {
        guard let product else { return }
        lblTitle.text = product.title
        lblCategory.text = product.category
        lblDescription.text = product.description
        lblPrice.text = "$\(product.price)"
        btnRate.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
    
}
