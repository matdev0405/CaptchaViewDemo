//
//  CaptchaView.swift
//  CaptchaViewDemo
//
//  Created by User on 2022/5/13.
//

import UIKit

// MARK: 基本的样式
struct CaptchaViewStytel {
    
    /// 随机颜色
    var kRandomColor:UIColor{
        return UIColor.init(red: CGFloat(Float(arc4random()%255)/255.0), green: CGFloat(Float(arc4random()%255)/255.0), blue: CGFloat(Float(arc4random()%255)/255.0), alpha: 1.0)
    }
    /// 线数量
    var kLineCount = 6
    /// 线宽
    var kLineWidth = 1.0
    /// 字符数量
    var kCharCount = 4
    /// 随机字体大小
    var kFontSize:UIFont?{
        return UIFont.systemFont(ofSize: CGFloat(Float(arc4random()%5) + 18))
    }
}


class CaptchaView: UIView {

    /// 字符素材数组
    var changeArray: NSArray?
    /// 验证码的字符串
    var changeString: String?
    /// 基本样式
    var stytel:CaptchaViewStytel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化
        self.setUpUI()
        // 显示一个随机验证码
        self.changeCaptcha()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: 初始化
    func setUpUI() -> Void {
       
      let stytel = CaptchaViewStytel()
      self.stytel = stytel
        
      self.backgroundColor = stytel.kRandomColor
       
      //设置layer圆角半径
      //self.layer.cornerRadius = 5.0
      //隐藏边界
      //self.layer.masksToBounds = true
        
    }
    
     // MARK: 布局约束
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = stytel.kRandomColor
       
        //点击界面，切换验证码
        self.changeCaptcha()
        
        //setNeedsDisplay调用drawRect方法来实现view的绘制
        self.setNeedsDisplay()
    }
    
    
   // MARK: 显示一个随机验证码
    func changeCaptcha(){
      
        // 从字符数组中随机抽取相应数量的字符，组成验证码字符串
        // 数组中存放的是全部可选的字符，可以是字母，也可以是中文
        let changeArray = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        self.changeArray = changeArray as NSArray
        self.changeString = String()
        
        // 随机从数组中选取需要个数的字符，然后拼接为一个字符串
        for _  in 0..<stytel.kCharCount {
            
            let index = arc4random()%(UInt32(changeArray.count - 1))
            
            let getStr = changeArray[Int(index)]
            
            self.changeString = "\(self.changeString!)\(getStr)"
        
        }
        
        // 从网络获取字符串，然后把得到的字符串在本地绘制出来（网络获取步骤在这省略）
        print("\(self.changeString!)")
      
    }
    
    // MARK:绘制界面（1.UIView初始化后自动调用； 2.调用setNeedsDisplay方法时会自动调用）
     override func draw(_ rect: CGRect) {
        
        // 重写父类方法，首先要调用父类的方法
         super.draw(rect)
       
        //设置随机背景颜色
        self.backgroundColor = stytel.kRandomColor
        
        //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
        let text = self.changeString
    
        let cSize = NSString(string: "S").size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        // 每个字符显示宽度的位置
        let width = (rect.size.width / CGFloat(text!.count)) - CGFloat(cSize.width)
        // 每个字符所显示高度位置
        let height = rect.size.height - cSize.height
        
        var point: CGPoint
        
        //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
        var pX,PY: CGFloat
       
        for i in 0..<text!.count {
            
            pX = CGFloat(Float(arc4random()%UInt32(width))) + rect.size.width / CGFloat(text!.count)*CGFloat(i)
            PY = CGFloat(Float(arc4random()%UInt32(height)))
            point = CGPoint(x: pX, y: PY)
            
            let texta = text! as NSString
            
            let c = texta.character(at: i)
            let textC = NSString(format: "%C", c)
        
            textC.draw(at: point, withAttributes: [NSAttributedString.Key.font : stytel.kFontSize!])
        }
        
   //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        let context = UIGraphicsGetCurrentContext()
        // 设置画线宽度
        context?.setLineWidth(CGFloat(stytel!.kLineWidth))
        
        // 绘制干扰的彩色直线
        for _ in 0..<stytel.kLineCount {
           
            // 设置线的随机颜色
            context?.setStrokeColor(stytel!.kRandomColor.cgColor)
            
            // 设置线的起点
            pX = CGFloat(Float(arc4random()%UInt32(rect.size.width)))
            PY = CGFloat(Float(arc4random()%UInt32(rect.size.height)))
            context?.move(to: CGPoint(x: pX, y: PY))
            
           //设置线终点
            pX = CGFloat(Float(arc4random()%UInt32(rect.size.width)))
            PY = CGFloat(Float(arc4random()%UInt32(rect.size.height)))
            context?.addLine(to: CGPoint(x: pX, y: PY))
           
            // 画线
            context?.strokePath()
        }
    }
    
    
    
}
