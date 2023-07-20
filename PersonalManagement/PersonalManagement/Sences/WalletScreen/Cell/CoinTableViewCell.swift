//
//  CoinTableViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 17/06/2023.
//

import UIKit
import DGCharts
import TinyConstraints

class CoinTableViewCell: UITableViewCell, ReuseCellType {
    @IBOutlet private weak var logoContainerView: UIView!
    @IBOutlet private weak var coinChartView: UIView!

    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false

        // Config yAxis
        let yAxis = chartView.leftAxis
        yAxis.enabled = false
        yAxis.setLabelCount(6, force: true)

        // Config xAxis
        let xAxis = chartView.xAxis
        xAxis.enabled = false

        chartView.pinchZoomEnabled = true
        chartView.doubleTapToZoomEnabled = false
        chartView.minOffset = 0
        chartView.animate(xAxisDuration: 0.5)
        chartView.legend.form = .none
        chartView.isUserInteractionEnabled = false

        return chartView
    }()

    var chartValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 6.0),
        ChartDataEntry(x: 1.0, y: 7.0),
        ChartDataEntry(x: 2.0, y: 4.0),
        ChartDataEntry(x: 3.0, y: 10.0),
        ChartDataEntry(x: 4.0, y: 2.0),
        ChartDataEntry(x: 5.0, y: 9.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 10.0),
        ChartDataEntry(x: 8.0, y: 8.0),
        ChartDataEntry(x: 9.0, y: 12.0),
        ChartDataEntry(x: 10.0, y: 1.0),
        ChartDataEntry(x: 11.0, y: 7.0),
        ChartDataEntry(x: 12.0, y: 0.9),
        ChartDataEntry(x: 13.0, y: 11.0),
    ]
    override func awakeFromNib() {
        super.awakeFromNib()
        logoContainerView.layer.cornerRadius = 12
        coinChartView.addSubview(lineChartView)
        coinChartView.layer.cornerRadius = 12
        lineChartView.edgesToSuperview()
        setDataForChart()
    }

    private func setDataForChart() {
        let setData = LineChartDataSet(entries: chartValues, label: "btc").with {
            $0.drawCirclesEnabled = false
            $0.mode = .cubicBezier
            $0.lineWidth = 2
            $0.setColor(.orange)
            $0.drawVerticalHighlightIndicatorEnabled = false
            $0.drawHorizontalHighlightIndicatorEnabled = false
//            $0.fill = ColorFill(color: .black)
//            $0.fillAlpha = 0.5
//            $0.drawFilledEnabled = true
//            $0.description = " This is decription"
            $0.label = .none
        }
        let dataChart = LineChartData(dataSet: setData).with {
            $0.setDrawValues(false)
        }
        lineChartView.data = dataChart
    }

}
