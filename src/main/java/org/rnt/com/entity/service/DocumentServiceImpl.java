package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.DocumentDao;
import org.rnt.com.entity.vo.DocumentVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("documentService")
public class DocumentServiceImpl extends BaseService implements DocumentService{

	@Resource(name="documentDao")
	private DocumentDao documentDao;

	@Override
	public RtnVO insert(DocumentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = documentDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(DocumentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = documentDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(DocumentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = documentDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(DocumentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = documentDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(DocumentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = documentDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(DocumentVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = documentDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
