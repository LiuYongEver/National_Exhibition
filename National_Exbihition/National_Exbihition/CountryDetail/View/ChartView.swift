//
//  ChartView.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/16.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import Charts

class ChartView: UIView,ChartViewDelegate{
  
    var pieChartView:PieChartView!
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setChart()
        // Drawing code
    }
    
    func setChart(){
        pieChartView = PieChartView.init(frame: FloatRect(0,20,SCREEN_WIDTH, SCREEN_HEIGHT/2))
        pieChartView.delegate = self
        
        pieChartView.animate(xAxisDuration: 1, easingOption: ChartEasingOption.easeOutSine)
        
        pieChartView.setExtraOffsets(left: 20, top: 0, right: 20, bottom: 0)
        self.addSubview(pieChartView)
        var yValues = [PieChartDataEntry]()
        var color:[UIColor] = []
        
        for i in 1...5{
            color.append(UIColor.randomColor)
            yValues.append(PieChartDataEntry.init(value: Double(i),
                                                  label: "数据",
                                                  icon: nil))
        }
        
        let dataSet = PieChartDataSet.init(values: yValues, label: "22")
        //dataSet.drawValuesEnabled = false
        //dataSet.selectionShift = 0
        // dataSet.valueLineVariableLength = false
        //dataSet.valueLinePart1Length = 0.8
        dataSet.colors = color
        //dataSet.yValuePosition = .outsideSlice
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        
        let data = PieChartData(dataSet: dataSet)
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        pieChartView.data = data
        pieChartView.chartDescription?.text = "右下角"
        
        let totalButton = UIButton(frame:Rect(47, 800, 658, 88))
        totalButton.backgroundColor = naviColor
        totalButton.layer.cornerRadius = 5
        totalButton.layer.masksToBounds = true
        totalButton.setTitleColor(UIColor.white, for: .normal)
        totalButton.setTitle("更多国家", for: .normal)
        self.addSubview(totalButton)
    }



}
