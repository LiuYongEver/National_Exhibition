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
    var totalButton = UIButton()
    var totoalRate = 0
    
    
    var dataBase:[ChartData_Populaton]?{
        didSet{
            setChart()
        }
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
    }
    
    func setChart(){
        
        
        for i in self.dataBase!{
            totoalRate = totoalRate + i.mid_year_population
        }
        let count = self.dataBase!.count
        
        
        pieChartView = PieChartView.init(frame: FloatRect(0,20,SCREEN_WIDTH, SCREEN_HEIGHT/2))
        pieChartView.delegate = self
        
        pieChartView.animate(xAxisDuration: 1, easingOption: ChartEasingOption.easeOutSine)
        
        pieChartView.setExtraOffsets(left: 20, top: 0, right: 20, bottom: 0)
        self.addSubview(pieChartView)
        var yValues = [PieChartDataEntry]()
        var color:[UIColor] = []
        
        for i in 0..<count{
            pieChartView.chartDescription?.text = dataBase![i].source

            color.append(UIColor.randomColor)
            let rate = Double(dataBase![i].mid_year_population)/Double(totoalRate)
            print(rate)
            let label = dataBase![i].nation_z
            
            
            yValues.append(PieChartDataEntry.init(value: rate*100,
                                                  label: label,
                                                  icon: nil))
        }
        
        let dataSet = PieChartDataSet.init(values: yValues, label: "图例")
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
        

    }



}
