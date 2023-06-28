package org.rnt.com.entity.service;

import javax.annotation.Resource;
import org.rnt.com.entity.dao.NoticeDao;
import org.rnt.com.entity.vo.NoticeVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("noticeService")
public class NoticeServiceImpl extends BaseService implements NoticeService{

	@Resource(name="noticeDao")
	private NoticeDao noticeDao;

	@Override
	public RtnVO insert(NoticeVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = noticeDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(NoticeVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = noticeDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(NoticeVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = noticeDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(NoticeVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = noticeDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(NoticeVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = noticeDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(NoticeVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = noticeDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
