package org.rnt.dashboard.service;

import javax.annotation.Resource;

import org.rnt.com.entity.vo.ProductionOrderVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.dao.DashboardMenuDao;
import org.rnt.dashboard.vo.DashboardProductionChartVO;
import org.springframework.stereotype.Service;

@Service("dashboardMenuService")
public class DashboardMenuServiceImpl extends BaseService implements DashboardMenuService {

	@Resource(name="dashboardMenuDao")
	private DashboardMenuDao dashboardMenuDao;
	
	@Override
	public RtnVO getDashboardEquipInfo() {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dashboardMenuDao.dashboardEquipSummary();
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO getDashboardAutoEquipInfo() {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dashboardMenuDao.dashboardAutoEquipSummary();
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO dashboardProductionChart(DashboardProductionChartVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dashboardMenuDao.dashboardProductionChart(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO dashboardProductionChartTotCnt(ProductionOrderVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dashboardMenuDao.dashboardProductionChartTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO dashboardAutoEquipChart(DashboardProductionChartVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dashboardMenuDao.dashboardAutoEquipChart(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO getDashboardProductionActWaitList() {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dashboardMenuDao.getDashboardProductionActWaitList();
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO getDashboardProductionActIngList() {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dashboardMenuDao.getDashboardProductionActIngList();
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

}
