//
//  toDoCell.swift
//  NotesKeeper
//
//  Created by G50 on 5/17/20.
//  Copyright © 2020 NotesKeeper. All rights reserved.
//

import UIKit

class toDoCell: UITableViewCell {
   
   //MARK:- IBOutlets
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.shadowColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
            backView.layer.cornerRadius = backView.frame.height / 5
            backView.layer.shadowOffset = CGSize(width: 3, height: 3)
            backView.layer.shadowOpacity = 0.5
            backView.layer.shadowRadius = 0.6
        }
    }
    
    
    @IBOutlet weak var priorityLBL: UILabel!{
        didSet{
            priorityLBL.layer.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            priorityLBL.layer.cornerRadius = priorityLBL.frame.width / 4
            priorityLBL.textColor = #colorLiteral(red: 0.05045407647, green: 0.2297388561, blue: 0.3413865963, alpha: 1)
        }
    }
    
    @IBOutlet weak var priorityValueLBL: UILabel!{
        didSet{
            priorityLBL.textColor = #colorLiteral(red: 0.05045407647, green: 0.2297388561, blue: 0.3413865963, alpha: 1)
        }
    }
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var upBtnOutlet: UIButton!
    @IBOutlet weak var downBtnOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
