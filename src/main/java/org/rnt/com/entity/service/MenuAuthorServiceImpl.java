package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MenuAuthorDao;
import org.rnt.com.entity.vo.MenuAuthorVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("menuAuthorService")
public class MenuAuthorServiceImpl extends BaseService implements MenuAuthorService{

	@Resource(name="menuAuthorDao")
	private MenuAuthorDao menuAuthorDao;

	@Override
	public RtnVO insert(MenuAuthorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuAuthorDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MenuAuthorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuAuthorDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MenuAuthorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuAuthorDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MenuAuthorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuAuthorDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MenuAuthorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuAuthorDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MenuAuthorVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuAuthorDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
