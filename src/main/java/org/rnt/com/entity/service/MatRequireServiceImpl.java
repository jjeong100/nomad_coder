package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.MatRequireDao;
import org.rnt.com.entity.vo.MatRequireVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("matRequireService")
public class MatRequireServiceImpl extends BaseService implements MatRequireService{

	@Resource(name="matRequireDao")
	private MatRequireDao matRequireDao;

	@Override
	public RtnVO insert(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchRequireMatList(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.searchRequireMatList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchMatRequireList(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.searchMatRequireList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO searchRequireMatListByChildProdSeq(MatRequireVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = matRequireDao.searchRequireMatListByChildProdSeq(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
