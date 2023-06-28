package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.DataBackupDao;
import org.rnt.com.entity.vo.DataBackupVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("dataBackupService")
public class DataBackupServiceImpl extends BaseService implements DataBackupService{

	@Resource(name="dataBackupDao")
	private DataBackupDao dataBackupDao;

	@Override
	public RtnVO insert(DataBackupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dataBackupDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(DataBackupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dataBackupDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(DataBackupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dataBackupDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(DataBackupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dataBackupDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(DataBackupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dataBackupDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(DataBackupVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = dataBackupDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
