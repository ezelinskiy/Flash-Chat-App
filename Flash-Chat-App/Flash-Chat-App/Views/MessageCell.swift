//
//  MessageCell.swift
//  Flash-Chat-App
//
//  Created by Evgeniy Zelinskiy on 26.01.2024.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var messageBgView: UIView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    var isMyMessage: Bool = false {
        didSet {
            leftImageView.isHidden = isMyMessage
            rightImageView.isHidden = !isMyMessage
            
            messageBgView.backgroundColor = isMyMessage ? UIColor.init(named: K.BrandColors.lightPurple) : UIColor.init(named: K.BrandColors.purple)
            messageBody.textColor = isMyMessage ? UIColor.init(named: K.BrandColors.purple) : UIColor.init(named: K.BrandColors.lightPurple)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        messageBgView.layer.cornerRadius = messageBgView.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
