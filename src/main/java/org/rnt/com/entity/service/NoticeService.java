package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.NoticeVO;
import org.rnt.com.vo.RtnVO;

public interface NoticeService {
	public RtnVO insert(NoticeVO param);
	public RtnVO select(NoticeVO param);
	public RtnVO update(NoticeVO param);
	public RtnVO delete(NoticeVO param);
	public RtnVO searchList(NoticeVO param);
	public RtnVO searchListTotCnt(NoticeVO param);
}
