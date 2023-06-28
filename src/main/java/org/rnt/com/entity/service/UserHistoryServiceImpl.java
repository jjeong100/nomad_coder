package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.UserHistoryDao;
import org.rnt.com.entity.vo.UserHistoryVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("userHistoryService")
public class UserHistoryServiceImpl extends BaseService implements UserHistoryService{

	@Resource(name="userHistoryDao")
	private UserHistoryDao userHistoryDao;

	@Override
	public RtnVO insert(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO createHistory(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			
			// 로그인 이력 생성. ip부여용
			userHistoryDao.createLoginHistory(param);
			
			rtn = userHistoryDao.createHistory(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectListExcel(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.selectListExcel(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO createLoginHistory(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.createLoginHistory(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO createTodayHistory(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.createTodayHistory(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO selectTodayHistoryList(UserHistoryVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = userHistoryDao.selectTodayHistoryList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
