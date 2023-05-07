//
//  ChartTableViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 11/06/2023.
//

import UIKit
import DGCharts
import TinyConstraints

final class ChartTableViewCell: UITableViewCell, ReuseCellType, ChartViewDelegate {

    @IBOutlet private weak var chartViewContainer: UIView!

    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor(#colorLiteral(red: 0.042927064, green: 0.5177074075, blue: 1, alpha: 1))
        chartView.rightAxis.enabled = false

        // Config yAxis
        let yAxis = chartView.leftAxis
        yAxis.setLabelCount(6, force: true)
        yAxis.labelPosition = .outsideChart

        // Config xAxis
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom

        chartView.animate(xAxisDuration: 2.5)

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
        chartViewContainer.addSubview(lineChartView)
        chartViewContainer.layer.cornerRadius = 12
        lineChartView.edgesToSuperview(insets: .top(6))
        setDataForChart()
    }

    private func setDataForChart() {
        let setData = LineChartDataSet(entries: chartValues, label: "Test").with {
            $0.drawCirclesEnabled = false
            $0.mode = .cubicBezier
            $0.lineWidth = 3
            $0.setColor(.white)
            $0.fill = ColorFill(color: .white)
            $0.fillAlpha = 0.8
            $0.drawFilledEnabled = true
        }
        let dataChart = LineChartData(dataSet: setData).with {
            $0.setDrawValues(false)
        }
        lineChartView.data = dataChart
    }

}
