//
//  ViewController.swift
//  Calculator
//
//  Created by Allison CHEN
//  Copyright © 2016年 Allison CHEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var numberLabel: NumberLabel!
	var tmpNumber: Double?
	var tmpOperator: String?
	var isAnswerDisplayed: Bool = false

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func numericButtonClicked(sender: AnyObject) {
		if isAnswerDisplayed {
			isAnswerDisplayed = false
			numberLabel.clear()
		}
		if sender.tag >= 1000 && sender.tag < 1010 {
			self.numberLabel.append(sender.tag - 1000)
		} else if sender.tag == 1010 {
			self.numberLabel.append(0)
			self.numberLabel.append(0)
		} else if sender.tag == 10 {
			self.numberLabel.appendFloatPoint()
		}
	}

	@IBAction func operatorButtonClicked(sender: AnyObject) {
		var newOperator: String!
		switch sender.tag {
		case 1:
			newOperator = "+"
		case 2:
			newOperator = "-"
		case 3:
			newOperator = "*"
		default:
			newOperator = "/"
		}

		if tmpNumber != nil {
			calculate(tmpOperator!, newValue: numberLabel.value)
			tmpNumber = numberLabel.value
		} else {
			tmpNumber = numberLabel.value
			numberLabel.clear()
		}
		tmpOperator = newOperator
	}

	@IBAction func clear(sender: AnyObject) {
		numberLabel.clear()
		tmpNumber = nil
		tmpOperator = nil
		isAnswerDisplayed = false
	}

	@IBAction func changeSign(sender: AnyObject) {
		numberLabel.changeSign()
	}

	@IBAction func convertToPercentage(sender: AnyObject) {
		numberLabel.toPercentage()
	}

	@IBAction func calculate(sender: AnyObject) {
		if tmpOperator == nil {
			return
		}
		calculate(tmpOperator!, newValue: numberLabel.value)
		tmpOperator = nil
	}

	func calculate(operand: String, newValue: Double) {
		var answer: Double!
		switch operand {
		case "+":
			answer = (tmpNumber ?? 0) + newValue
		case "-":
			answer = (tmpNumber ?? 0) - newValue
		case "*":
			answer = (tmpNumber ?? 0) * newValue
		case "/":
			answer = (tmpNumber ?? 0) / newValue
		default:
			answer = newValue
		}

		if let value = answer {
			numberLabel.value = value
			isAnswerDisplayed = true
		} else {
			numberLabel.text = "錯誤"
		}
		tmpNumber = nil
	}
}
