package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.TranSpecDao;
import org.rnt.com.entity.vo.TranSpecVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("tranSpecService")
public class TranSpecServiceImpl extends BaseService implements TranSpecService{

	@Resource(name="tranSpecDao")
	private TranSpecDao tranSpecDao;
	
	@Override
	public RtnVO selectCompany(TranSpecVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = tranSpecDao.selectCompany(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
