//
//  DecimalMinusTextField.swift
//
//  Created by Jonathan Engelsma on 9/24/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

/**
    An extension to UITextField that augments the standard decimal keypad with
    a minus button and a done button.  The implementation was inspired by this 
    particular question/answer thread:
        http://stackoverflow.com/questions/9613109/uikeyboardtypedecimalpad-with-negative-numbers
*/
class DecimalMinusTextField: UITextField {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.keyboardType = UIKeyboardType.DecimalPad

    }
    
    private func getAccessoryButtons() -> UIView
    {
        var view = UIView(frame: CGRectMake(0, 0, self.superview!.frame.size.width, 44))
        view.backgroundColor = UIColor.lightGrayColor()
        
        var minusButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        var doneButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        minusButton.setTitle("-", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        var buttonWidth = view.frame.size.width/3;
        minusButton.frame = CGRectMake(0, 0, buttonWidth, 44);
        doneButton.frame = CGRectMake(view.frame.size.width - buttonWidth, 0, buttonWidth, 44);
        
        minusButton.addTarget(self, action: "minusTouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.addTarget(self, action: "doneTouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(minusButton)
        view.addSubview(doneButton)
        
        return view;
    }
    
    func minusTouchUpInside(sender: UIButton!) {

        let text = self.text
        if(count(text) > 0) {
            var index: String.Index = advance(text.startIndex, 1)
            let firstChar = text.substringToIndex(index)
            if firstChar == "-" {
                self.text = text.substringFromIndex(index)
            } else {
                self.text = "-" + text
            }
        }
    }
    
    func doneTouchUpInside(sender: UIButton!) {
        self.resignFirstResponder();
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.inputAccessoryView = getAccessoryButtons()
    }


}
