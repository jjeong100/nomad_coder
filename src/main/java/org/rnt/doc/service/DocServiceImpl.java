package org.rnt.doc.service;

import javax.annotation.Resource;

import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.rnt.doc.dao.DocDao;
import org.rnt.doc.vo.DocVO;
import org.springframework.stereotype.Service;

@Service("docService")
public class DocServiceImpl extends BaseService implements DocService {

	@Resource(name="docDao")
	private DocDao docDao;

	@Override
	public RtnVO searchDocList(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = docDao.searchDocList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchDocListTotCnt(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = docDao.searchDocListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO insert(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = docDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
	
	@Override
	public RtnVO delete(DocVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = docDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

}
