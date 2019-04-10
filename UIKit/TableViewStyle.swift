//
//  TableViewStyle.swift
//  XBTableViewDemo
//
//  Created by xiaobin liu on 2019/4/10.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit
import Foundation

/// MARK - 指示器协议
protocol IndicatorDisplay {
    
    /// 显示指示器
    ///
    /// - Parameter view: <#view description#>
    func showIndicator(in view: UIView)
    
    /// 隐藏指示器
    ///
    /// - Parameter view: <#view description#>
    func hideIndicator(from view: UIView)
}

// MARK: - <#Description#>
extension IndicatorDisplay {
    
    /// 显示指示器在那个View
    ///
    /// - Parameter view: <#view description#>
    func showIndicator(in view: UIView) {
        
        let holderView = IndicatorHolderView()
        
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        holderView.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: holderView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: holderView.centerYAnchor).isActive = true
        indicator.startAnimating()
        
        holderView.backgroundColor = .clear
        view.addSubview(holderView)
        
        holderView.translatesAutoresizingMaskIntoConstraints = false
        holderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        holderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        holderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        holderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    /// 隐藏指示器
    ///
    /// - Parameter view: <#view description#>
    func hideIndicator(from view: UIView) {
        let holder = view.subviews.first { $0 is IndicatorHolderView }
        holder?.removeFromSuperview()
    }
}


/// MARK - 指标持有者视图
public class IndicatorHolderView: UIView {}

// MARK: - UIView
extension IndicatorDisplay where Self: UIView {
    
    /// 显示指示器
    func showIndicator() {
        showIndicator(in: self)
    }
    
    /// 隐藏指示器
    func hideIndicator() {
        hideIndicator(from: self)
    }
}


// MARK: - UIViewController
extension IndicatorDisplay where Self: UIViewController {
    
    /// 显示指示器
    func showIndicator() {
        showIndicator(in: view)
    }
    
    /// 隐藏指示器
    func hideIndicator() {
        hideIndicator(from: view)
    }
}


/// MARK - 自定义View协议
protocol CustomView {
    
    associatedtype ViewClass: UIView
    
    var customView: ViewClass { get }
}

extension CustomView where Self: UIViewController {
    
    var customView: ViewClass {
        guard let customView = self.view as? ViewClass else {
            fatalError("Couldn't cast. Type incompatibility \(#file):\(#line)")
        }
        return customView
    }
}



/// MARK - 基类TableView
open class BaseView: UIView, IndicatorDisplay {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    /// 初始化
    public init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    /// 添加View
    private func addSubviews() {
        
        [tableView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    /// 设置位置
    private func setupConstraints() {
        
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    
    /// 切换活动指示器
    ///
    /// - Parameter toggle: <#toggle description#>
    public func toggleActivityIndicator(_ toggle: Bool) {
        if toggle {
            showIndicator()
        } else {
            hideIndicator()
        }
    }
    
    
    /// 设置TableView 数据源与回调
    ///
    /// - Parameters:
    ///   - dataSource: <#dataSource description#>
    ///   - delegate: <#delegate description#>
    public func setTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        self.tableView.dataSource = dataSource
        self.tableView.delegate = delegate
    }
    
    
    /// 注册Cell
    ///
    /// - Parameters:
    ///   - cellType: <#cellType description#>
    ///   - identifier: <#identifier description#>
    public func register(cellType: UITableViewCell.Type, forCellReuseIdentifier identifier: String) {
        tableView.register(cellType, forCellReuseIdentifier: identifier)
    }
    
    
    /// 表示单元格的行和节的索引路径，如果索引路径无效则为nil。
    ///
    /// - Parameter cell: <#cell description#>
    /// - Returns: <#return value description#>
    public func indexPath(for cell: UITableViewCell) -> IndexPath? {
        return tableView.indexPath(for: cell)
    }
    
    
    /// 刷新列表
    public func refreshTableView() {
        tableView.reloadData()
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class DemoViewController: UIViewController, CustomView {
    
    typealias ViewClass = BaseView
    
    override func loadView() {
        self.view = ViewClass()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
