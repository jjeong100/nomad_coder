package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MenuDao;
import org.rnt.com.entity.vo.MenuVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("menuService")
public class MenuServiceImpl extends BaseService implements MenuService{

	@Resource(name="menuDao")
	private MenuDao menuDao;

	@Override
	public RtnVO insert(MenuVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MenuVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MenuVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MenuVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MenuVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MenuVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = menuDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
