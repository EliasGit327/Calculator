//
//  ViewController.swift
//  Testing
//
//  Created by Elias on 2/22/19.
//  Copyright © 2019 Elias Smith. All rights reserved.
//

import UIKit
import Toast_Swift
import SQLite

var height: CGFloat!
var width: CGFloat!

var viewRef : UIView? = nil

public var myView: UIView? = nil

let dataTable = Table("Data")

let name = Expression<String>("Names")
let btnPressed = Expression<Int>("Buttons Pressed")
let firstNumbers = Expression<String>("First numbers")
let secondNumbers = Expression<String>("Second numbers")
let results = Expression<String>("Results")

public final class userData {
  public static var name = "Unknown"
  public static var buttonPressed: Int = 0
  public static var dataBasePub: Connection!

}

class ViewController: UIViewController {
  
  var dataBase: Connection!
  
  @IBOutlet weak var rightView: UIView!
  @IBOutlet weak var leftView: UIView!
  
  //______________________________________
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var clearButton: UIButton!
  
  //_____________________________________
  var originalLeftSize: CGFloat = 0
  var originalMainSize: CGFloat = 0
  
  var land = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    height = UIScreen.main.bounds.height
    width = UIScreen.main.bounds.width
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      self.alert()
    }
    
    let dbDirrectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileUrl = dbDirrectory?.appendingPathComponent("User").appendingPathExtension("sqlite3")
    let dataBase = try? Connection(fileUrl!.path)
    self.dataBase = dataBase
    
    userData.dataBasePub = dataBase
    
    if(!checkIfTablesExist()) {
      createTable()
    }
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(removeLast(sender:)))
    swipe.direction = [.left, .right]
    //MARK: SWIPE GESTURE
    label.addGestureRecognizer(swipe)
    label.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(presentSecondVC)))
    
    
    //Long press on Clear button
    clearButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap)))
    
    originalLeftSize = leftView.frame.size.width
    originalMainSize = rightView.frame.size.width
    
    myView = self.view
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(false)
    getStringStatsFromDB()
  }
  
  @objc func removeLast(sender: UISwipeGestureRecognizer) {
    if sender.direction != .down && sender.direction != .up && sender.state == .ended {
      if( label.text?.count != 1 ) {
        label.text?.removeLast()
      } else {
        label.text = "0"
        firstNum = true
      }
    }
  }
  
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    label.text = "0"
    firstNum = true
  }
  

  @objc func handleLongTap() {
    label.text = "0"
    firstNum = true
    
  }
  
  @IBAction func onOneButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 1)
    userData.buttonPressed+=1
  }
  
  @IBAction func onTwoButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 2)
    userData.buttonPressed+=1
  }
  
  @IBAction func onThreeButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 3)
    userData.buttonPressed+=1
  }
  
  @IBAction func onFourButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 4)
    userData.buttonPressed+=1
  }
  
  @IBAction func onFiveButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 5)
    userData.buttonPressed+=1
  }
  
  @IBAction func onSixButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 6)
    userData.buttonPressed+=1
  }
  
  @IBAction func onSevenButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 7)
    userData.buttonPressed+=1
  }
  
  @IBAction func onEightButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 8)
    userData.buttonPressed+=1
  }
  
  @IBAction func onNineButtonClick(_ sender: Any) {
    addNum(labelOfFunc: label, number: 9)
    userData.buttonPressed+=1
  }
  
  @IBAction func onZeroButtonClick(_ sender: Any ) {
    addZero( labelOfFunc: label )
    userData.buttonPressed+=1
  }
  
  @IBAction func onDotButtonClick(_ sender: Any) {
    addDot( labelOfFunc: label )
    userData.buttonPressed+=1
  }
  
  @IBAction func onClearButtonClick(_ sender: Any) {
    deleteLast( labelOfFunc: label )
    userData.buttonPressed+=1
  }
  
  @IBAction func onPlusMinusButtonClick(_ sender: Any) {
    label.text = multiplyOnMinusOne(labelOfFunc: label)
    userData.buttonPressed+=1
  }
  
  @IBAction func onPercentageButtonClick(_ sender: Any) {
    percentage(labelOfFunc: label)
    userData.buttonPressed+=1
  }
  
  @IBAction func onDivideButtonClick(_ sender: Any) {
    prepareForOperation(labelOfFunc: label, opTypeIn: "divide")
    userData.buttonPressed+=1
  }
  
  @IBAction func onMultiplyButton(_ sender: Any) {
    prepareForOperation(labelOfFunc: label, opTypeIn: "multiply")
    userData.buttonPressed+=1
  }
  
  @IBAction func onMinusButtonClick(_ sender: Any) {
    prepareForOperation(labelOfFunc: label, opTypeIn: "minus")
    userData.buttonPressed+=1
  }
  
  @IBAction func onPlusButtonClick(_ sender: Any) {
    prepareForOperation(labelOfFunc: label, opTypeIn: "plus")
    userData.buttonPressed+=1
  }
  
  @IBAction func onEqualButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    doOperation(labelOfFunc: label)
  }
  
  @IBAction func onPiButtonClick(_ sender: Any) {
    getPi(labelOfFunc: label)
    userData.buttonPressed+=1
  }
  
  @IBAction func onGetEButtonClick(_ sender: Any) {
    getE(labelOfFunc: label)
    userData.buttonPressed+=1
  }
  
  @IBAction func onRandButtonClick(_ sender: Any) {
    getRadnomNum(labelOfFunc: label)
    userData.buttonPressed+=1
  }
  
  @IBAction func on10powButtonClick(_ sender: Any) {
    get10pow(labelOfFunc: label)
    userData.buttonPressed+=1
  }
  
  @IBAction func onLeftArrowClick(_ sender: Any) {
    moveToLeft(labelOfFunc: label)
  }
  
  @IBAction func onRightArrowClick(_ sender: Any) {
    moveToRight(labelOfFunc: label)
  }
  
  @IBAction func onOneDivideX(_ sender: Any) {
    userData.buttonPressed+=1
    oneDivide(labelOfFunc: label)
  }
  
  @IBAction func xFactorial(_ sender: Any) {
    userData.buttonPressed+=1
    doFactorial(labelOfFunc: label)
  }
  
  @IBAction func xInTheSecondPower(_ sender: Any) {
    userData.buttonPressed+=1
    secondPower(labelOfFunc: label)
  }
  
  @IBAction func xInTheThirdPower(_ sender: Any) {
    userData.buttonPressed+=1
    thirdPower(labelOfFunc: label)
  }
  
  @IBAction func logE(_ sender: Any) {
    userData.buttonPressed+=1
    logEfun(labelOfFunc: label)
  }
  
  @IBAction func log2(_ sender: Any) {
    userData.buttonPressed+=1
    log2fun(labelOfFunc: label)
  }
  
  @IBAction func logWithXandYClick(_ sender: Any) {
    userData.buttonPressed+=1
    logWithXY(labelOfFunc: label)
  }
  
  @IBAction func onSinButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    sinFun(labelOfFunc: label)
  }
  
  @IBAction func onCosButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    cosFun(labelOfFunc: label)
  }
  
  @IBAction func onTanButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    tanFun(labelOfFunc: label)
  }
  
  @IBAction func onArcSinButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    aSinFun(labelOfFunc: label)
  }
  
  @IBAction func onArcCosButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    aCosFun(labelOfFunc: label)
  }
  
  @IBAction func onArcTanButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    aTanFun(labelOfFunc: label)
  }
  
  @IBAction func sqrt_2xonButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    sqrt2(labelOfFunc: label)
  }
  
  @IBAction func sqrt_3xonButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    sqrt3(labelOfFunc: label)
  }
  
  @IBAction func sqrt_XYonButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    sqrtXY(labelOfFunc: label)
  }
  
  @IBAction func onXYpowerButtonClick(_ sender: Any) {
    userData.buttonPressed+=1
    prepareForOperation(labelOfFunc: label, opTypeIn: "powerXY")
  }
  
  func landsacpeUI() -> Void {
    
    if( land != true ) {
      
      land = true
      self.label.alpha = 0
      
      UIView.animate(withDuration: 0.3, animations: {
        
        self.leftView.frame.size.width = UIScreen.main.bounds.width / 5 * 3
        self.leftView.frame.origin.x = 0

        self.rightView.frame.size.width = UIScreen.main.bounds.width / 5 * 2
        self.rightView.frame.origin.x = self.leftView.frame.size.width + 0.5

        
      }) { (finished) in
        UIView.animate(withDuration: 0.25, animations: {
          self.label.alpha = 1.0
        })
      }
      
      
    }
    
  }
  
  
  func portairUI() -> Void {
    
    if( land != false ) {
      
      land = false
      self.label.alpha = 0
      
      UIView.animate(withDuration: 0.3, animations: {
        self.leftView.frame.size.width = self.originalLeftSize
        self.leftView.frame.origin.x = self.originalLeftSize * -1

        self.rightView.frame.size.width = UIScreen.main.bounds.width
        self.rightView.frame.origin.x = 0
        
      }) { (finished) in
        UIView.animate(withDuration: 0.25, animations: {
          self.label.alpha = 1.0
        })
      }
      
      
    }
    
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    
    if UIDevice.current.orientation.isLandscape {
      print("Landscape")
      landsacpeUI()
    } else {
      print("Portrait")
      portairUI()
    }
  }
  
  @objc func presentSecondVC() {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
    vc.textViewString = printAllDataUI()
    self.present(vc, animated: true, completion: nil)
  }
  
  func alert() {
    let alert = UIAlertController(title: NSLocalizedString("enter message", comment: ""), message: NSLocalizedString("welcome message", comment: ""), preferredStyle: .alert)
    alert.addTextField { (textField) in textField.placeholder = NSLocalizedString("username tip", comment: "") }
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
      let textField = alert!.textFields![0]
      
      if(textField.text!.count > 0){ userData.name = textField.text! }
    }))
    
    present(alert, animated: true, completion: nil )
  }
  
  func createTable() {
    
    do {
      try dataBase.run(dataTable.create(ifNotExists: true) { t in
        t.column(name)
        t.column(btnPressed)
        t.column(firstNumbers)
        t.column(secondNumbers)
        t.column(results)
      })
      
      print("Table has been created")
    } catch {
      print("Table has not been created")
      print(error)
    }
  }
  
  func checkIfTablesExist() -> Bool {
    do {
      try dataBase.scalar(dataTable.exists)
      
      print("Exists")
      return true
      //exists
      
    } catch {
      //doesn't
      print("Not Exists")
      return false
    }
  }
  
  public func printAllDataUI() -> String {
    var message = ""
    do {
      for data in try userData.dataBasePub.prepare(dataTable) {
        message.append("\((NSLocalizedString("name", comment: ""))): \(data[name])\n \(NSLocalizedString("buttons pressed", comment: "")): \(data[btnPressed])\n \(NSLocalizedString("first number", comment: "")): \(data[firstNumbers])\n \(NSLocalizedString("second number", comment: "")): \(data[secondNumbers])\n \(NSLocalizedString("result", comment: "")): \(data[results])\n\n")
      }
    } catch {
      print(error)
    }
    
    return message
  }
  

  
}

public func addRow(nameIn: String, btnPressedIn: Int, firstNumIn: String, secondNumIn: String, resultIn: String) {
  do {
    try userData.dataBasePub.run(dataTable.insert(name <- nameIn, btnPressed <- btnPressedIn, firstNumbers <- firstNumIn, secondNumbers <- secondNumIn, results <- resultIn))
    
    getStringStatsFromDB()
  } catch {
    print(error)
  }
}

public func getStringStatsFromDB() {
  
  do {
    for data in try userData.dataBasePub.prepare(dataTable) {
      print("Name: \(data[name]), Buttons: \(data[btnPressed]), FirstN: \(data[firstNumbers]), SecondN: \(data[secondNumbers]), Result: \(data[results])")
    }
  } catch {
    print(error)
  }
}
