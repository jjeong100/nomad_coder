package org.rnt.dashboard.service;

import javax.annotation.Resource;

import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.dashboard.dao.AutoEquipMenuDao;
import org.rnt.dashboard.vo.AutoEquipVO;
import org.springframework.stereotype.Service;

@Service("autoEquipMenuService")
public class AutoEquipMenuServiceImpl extends BaseService implements AutoEquipMenuService {

	@Resource(name="autoEquipMenuDao")
	private AutoEquipMenuDao autoEquipMenuDao;
	
	@Override
	public RtnVO searchFrontAutoEquipList(AutoEquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = autoEquipMenuDao.searchFrontAutoEquipList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
    public RtnVO searchFrontAutoEquipListTotCnt(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = autoEquipMenuDao.searchFrontAutoEquipListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
	public RtnVO searchRearAutoEquipList(AutoEquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = autoEquipMenuDao.searchRearAutoEquipList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
    public RtnVO searchRearAutoEquipListTotCnt(AutoEquipVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = autoEquipMenuDao.searchRearAutoEquipListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
	
	@Override
	public RtnVO searchFrontAutoEquipSummary(AutoEquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = autoEquipMenuDao.searchFrontAutoEquipSummary(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchFrontAutoEquipChart(AutoEquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = autoEquipMenuDao.searchFrontAutoEquipChart(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchRearAutoEquipSummary(AutoEquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = autoEquipMenuDao.searchRearAutoEquipSummary(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchRearAutoEquipChart(AutoEquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = autoEquipMenuDao.searchRearAutoEquipChart(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectItemImage(AutoEquipVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = autoEquipMenuDao.selectItemImage(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

}
