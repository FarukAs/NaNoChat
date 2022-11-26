//
//  MessageCell.swift
//  NaNoChat
//
//  Created by Şeyda Soylu on 10.11.2022.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var rightİmageView: UIImageView!
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var leftİmageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = view.layer.frame.height / 10
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
    }
    
}
