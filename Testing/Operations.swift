//
//  Operations.swift
//  Testing
//
//  Created by Elias on 3/5/19.
//  Copyright © 2019 Elias Smith. All rights reserved.
//

import Foundation
import SQLite
import UIKit
import Toast_Swift

var currentNum : Double! = nil
var previousNum: Double! = nil
var firstNum = true

var opType = ""

public func addZero( labelOfFunc : UILabel! ) {
  
  if(!firstNum) {
    
    labelOfFunc.text?.append("0")
  } else {
    labelOfFunc.text! = "0"
  }
  
}

public func addNum( labelOfFunc: UILabel! , number : Int) {
  if(firstNum) {
    labelOfFunc.text = String(number)
    firstNum = false
  } else {
    labelOfFunc.text?.append( String(number) )
    
  }
}




public func addDot( labelOfFunc : UILabel! ) {
  
  if(!labelOfFunc.text!.contains(".")) {
    firstNum = false
    labelOfFunc.text?.append(".")
  }
  
}

public func deleteLast( labelOfFunc: UILabel! ) {
  
  if( labelOfFunc.text?.count != 1 ) {
    
    labelOfFunc.text?.removeLast()
  } else {
    firstNum = true
    labelOfFunc.text = "0"
  }
  
}

public func multiplyOnMinusOne( labelOfFunc: UILabel! ) -> String {
  let num = -1 * getDoubleValue(text: labelOfFunc.text!)
  return getStringValue(value: num)
}

public func getDoubleValue( text: String ) -> Double {
  
  return (text as NSString).doubleValue
}

public func getStringValue( value: Double ) -> String {
  
  //return String( format: "%g", value )
  if(value.truncatingRemainder(dividingBy: 1) == 0){
    return String( format: "%.0f", value)
  } else {
    return String(value)
  }
}

public func percentage( labelOfFunc: UILabel! ) {
  
  labelOfFunc.text! = getStringValue(value: ( getDoubleValue(text: labelOfFunc.text!) / 100 ) )
}

public func multiply( labelOfFunc: UILabel! ) {
  
  prepareForOperation(labelOfFunc: labelOfFunc, opTypeIn: "multiply")
}

public func prepareForOperation( labelOfFunc: UILabel!, opTypeIn: String ) {
  
  previousNum = getDoubleValue(text: labelOfFunc.text!)
  
  print("Previous:", previousNum)
  opType = opTypeIn
  labelOfFunc.text! = "0"
  firstNum = true
}

public func doOperation( labelOfFunc: UILabel! ) {
  
  switch opType {
  case "multiply": do {
    currentNum = getDoubleValue(text: labelOfFunc.text!)
    
    let result = getStringValue(value: previousNum * currentNum )
    labelOfFunc.text = result
    opType = ""
    firstNum = true
    
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: getStringValue(value: previousNum), secondNumIn: getStringValue(value: currentNum), resultIn: result)
    userData.buttonPressed = 0
    
    }
    
  case "divide": do {
    currentNum = getDoubleValue( text: labelOfFunc.text! )
    print("Current:", currentNum)
    
    let result = getStringValue(value: previousNum / currentNum )
    
    if(currentNum != 0) {
      labelOfFunc.text = result
    } else {
      labelOfFunc.text = "0"
      
      let style = ToastStyle()
      myView?.makeToast(NSLocalizedString("divide by 0 message", comment: ""), style: style)
    }
    
    opType = ""
    firstNum = true
    
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: getStringValue(value: previousNum), secondNumIn: getStringValue(value: currentNum), resultIn: result)
    userData.buttonPressed = 0
    }
    
  case "plus" :  do {
    currentNum = getDoubleValue(text: labelOfFunc.text!)
    
    let result = getStringValue(value: previousNum + currentNum )
    labelOfFunc.text = result
    opType = ""
    firstNum = true
    
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: getStringValue(value: previousNum), secondNumIn: getStringValue(value: currentNum), resultIn: result)
    
    userData.buttonPressed = 0
    }
    
  case "minus":  do {
    currentNum = getDoubleValue(text: labelOfFunc.text!)
    
    let result = getStringValue(value: previousNum - currentNum )
    labelOfFunc.text = result
    opType = ""
    firstNum = true
    
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: getStringValue(value: previousNum), secondNumIn: getStringValue(value: currentNum), resultIn: result)
    
    userData.buttonPressed = 0
    }
    
  case "logXY":  do {
    currentNum = getDoubleValue(text: labelOfFunc.text!)
    
    let result = getStringValue(value: log(currentNum) / log(previousNum) )
    labelOfFunc.text = result
    opType = ""
    firstNum = true
    
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: getStringValue(value: previousNum), secondNumIn: getStringValue(value: currentNum), resultIn: result)
    
    userData.buttonPressed = 0
    }
    
  case "sqrtXY":  do {
    currentNum = getDoubleValue(text: labelOfFunc.text!)
    
    let result = getStringValue(value: pow(currentNum, 1/previousNum) )
    labelOfFunc.text = result
    opType = ""
    firstNum = true
    
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: getStringValue(value: previousNum), secondNumIn: getStringValue(value: currentNum), resultIn: result)
    
    userData.buttonPressed = 0
    }
    
  case "powerXY":  do {
    currentNum = getDoubleValue(text: labelOfFunc.text!)
    
    let result = pow(previousNum, currentNum)
    
    let newResult = getStringValue(value: result )
    labelOfFunc.text = newResult
    opType = ""
    firstNum = true
    
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: getStringValue(value: previousNum), secondNumIn: getStringValue(value: currentNum), resultIn: newResult)
    
    userData.buttonPressed = 0
    }
    
  default: print("")
  }
}


public func getPi(labelOfFunc: UILabel) {
  
  labelOfFunc.text = "3.14159"
  firstNum = true
  
  addRow(nameIn: userData.name, btnPressedIn: 1, firstNumIn: "none", secondNumIn: "none", resultIn: "3.14159")
}

public func getE(labelOfFunc: UILabel) {
  
  labelOfFunc.text = "2.71828"
  firstNum = true
  
  addRow(nameIn: userData.name, btnPressedIn: 1, firstNumIn: "none", secondNumIn: "none", resultIn: "2.71828")
}

public func eInPowerX(labelOfFunc: UILabel) {
  let x = getDoubleValue(text: labelOfFunc.text!)
  let result = pow(2.71828, x)
  userData.buttonPressed+=1
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  userData.buttonPressed = 0
  labelOfFunc.text = getStringValue(value: result)
  firstNum = true
}

public func getRadnomNum(labelOfFunc: UILabel) {
  
  labelOfFunc.text = getStringValue(value: (Double(arc4random()) / Double(UINT32_MAX)))
  firstNum = true
}

public func get10pow(labelOfFunc: UILabel) {
  let result = getStringValue(value: pow(10 , getDoubleValue(text: labelOfFunc.text!)))
  
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: result)
  
  labelOfFunc.text = result
  firstNum = true
  userData.buttonPressed = 0
}

public func moveToRight(labelOfFunc: UILabel) {
  let result = getStringValue(value: getDoubleValue(text: labelOfFunc.text!) / 10)
  userData.buttonPressed+=1
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: result)
  labelOfFunc.text = result
  firstNum = true
  userData.buttonPressed = 0
}

public func moveToLeft(labelOfFunc: UILabel) {
  let result = getStringValue(value: getDoubleValue(text: labelOfFunc.text!) * 10)
  userData.buttonPressed+=1
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: result)
  labelOfFunc.text = result
  firstNum = true
  userData.buttonPressed = 0
}

public func oneDivide(labelOfFunc: UILabel) {
  firstNum = true
  
  let num = labelOfFunc.text!
  
  if(num == "0") {
    myView?.makeToast(NSLocalizedString("divide by 0 message", comment: ""))
    firstNum = true
    labelOfFunc.text = "0"
  } else {
    
    let result = 1 / getDoubleValue(text: labelOfFunc.text!)
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
    labelOfFunc.text = getStringValue(value: result)
    userData.buttonPressed = 0
  }
  
}

public func doFactorial(labelOfFunc: UILabel) {
  
  let num = getDoubleValue(text: labelOfFunc.text!)
  
  var result = 1.0
  var i = 1.0
  
  if(num.truncatingRemainder(dividingBy: 1) == 0){
    while(i-1<num){
      result = result * i
      i += 1
    }
    addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
    labelOfFunc.text = getStringValue(value: result)
  } else {
    myView?.makeToast(NSLocalizedString("not int", comment: ""))
    labelOfFunc.text = "0"
    userData.buttonPressed = 0
  }
  
  
  firstNum = true
}

public func secondPower(labelOfFunc: UILabel) {
  
  let num = getDoubleValue(text: labelOfFunc.text!)
  
  let result = num * num
  
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func thirdPower(labelOfFunc: UILabel) {
  
  let num = getDoubleValue(text: labelOfFunc.text!)
  
  let result = num * num * num
  
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func logEfun(labelOfFunc: UILabel) {
  
  let result = log(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func log2fun(labelOfFunc: UILabel) {
  
  let result = log2(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func logWithXY(labelOfFunc: UILabel) {
  
  prepareForOperation(labelOfFunc: labelOfFunc, opTypeIn: "logXY")
  
}

public func sinFun(labelOfFunc: UILabel) {
  let result = sin(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func cosFun(labelOfFunc: UILabel) {
  let result = cos(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func tanFun(labelOfFunc: UILabel) {
  let result = tan(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}


public func aSinFun(labelOfFunc: UILabel) {
  let result = asin(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func aCosFun(labelOfFunc: UILabel) {
  let result = acos(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func aTanFun(labelOfFunc: UILabel) {
  let result = atan(getDoubleValue(text: labelOfFunc.text!))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: getStringValue(value: result))
  labelOfFunc.text = getStringValue(value: result)
  userData.buttonPressed = 0
  firstNum = true
}

public func sqrt2(labelOfFunc: UILabel) {
  let variable = getDoubleValue(text: labelOfFunc.text!)
  let result = getStringValue(value: sqrt(variable))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: result)
  labelOfFunc.text = result
  userData.buttonPressed = 0
  firstNum = true
}

public func sqrt3(labelOfFunc: UILabel) {
  let variable = getDoubleValue(text: labelOfFunc.text!)
  let result = getStringValue(value: pow(variable, 1/3))
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: result)
  labelOfFunc.text = result
  userData.buttonPressed = 0
  firstNum = true
}

public func sqrtXY(labelOfFunc: UILabel) {
  prepareForOperation(labelOfFunc: labelOfFunc, opTypeIn: "sqrtXY")
}

public func dltAfterDot(labelOfFunc: UILabel) {
  
  let result = String( format: "%.0f", getDoubleValue(text: labelOfFunc.text!))
  
  addRow(nameIn: userData.name, btnPressedIn: userData.buttonPressed, firstNumIn: labelOfFunc.text!, secondNumIn: "none", resultIn: result)
  
  userData.buttonPressed = 0
  labelOfFunc.text = result
}


public func mClear(labelOfFunc: UILabel) {
  userData.memory = 0
}

public func mAdd(labelOfFunc: UILabel) {
  userData.memory += getDoubleValue(text: labelOfFunc.text!)
  firstNum = true
  labelOfFunc.text = "0"
}

public func mMinus(labelOfFunc: UILabel) {
  userData.memory -= getDoubleValue(text: labelOfFunc.text!)
  firstNum = true
  labelOfFunc.text = "0"
}

public func mPresent(labelOfFunc: UILabel) {
  labelOfFunc.text = getStringValue(value: userData.memory)
}
