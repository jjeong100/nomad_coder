package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.OutSocVO;
import org.rnt.com.vo.RtnVO;

public interface OutSocService {
	public RtnVO insert(OutSocVO param);
	public RtnVO select(OutSocVO param);
	public RtnVO update(OutSocVO param);
	public RtnVO delete(OutSocVO param);
	public RtnVO searchList(OutSocVO param);
	public RtnVO searchListTotCnt(OutSocVO param);
}
