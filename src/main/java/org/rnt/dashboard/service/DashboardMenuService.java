package org.rnt.dashboard.service;

import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.vo.DashboardProductionChartVO;

public interface DashboardMenuService {
	public RtnVO getDashboardEquipInfo();
	public RtnVO getDashboardAutoEquipInfo();
	public RtnVO dashboardProductionChart(DashboardProductionChartVO param);
	public RtnVO dashboardProductionChartTotCnt(ProductionOrderVO param);
	public RtnVO dashboardAutoEquipChart(DashboardProductionChartVO param);
	public RtnVO getDashboardProductionActWaitList();
	public RtnVO getDashboardProductionActIngList();
}
