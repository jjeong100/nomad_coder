package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.CalanderVO;
import org.rnt.com.vo.RtnVO;

public interface CalanderService {
	public RtnVO insert(CalanderVO param);
	public RtnVO select(CalanderVO param);
	public RtnVO update(CalanderVO param);
	public RtnVO delete(CalanderVO param);
	public RtnVO searchList(CalanderVO param);
	public RtnVO searchListTotCnt(CalanderVO param);
}
