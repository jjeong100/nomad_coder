package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.CompanyVO;
import org.rnt.com.vo.RtnVO;

public interface CompanyService {
	public RtnVO insert(CompanyVO param);
	public RtnVO select(CompanyVO param);
	public RtnVO update(CompanyVO param);
	public RtnVO delete(CompanyVO param);
	public RtnVO searchList(CompanyVO param);
	public RtnVO searchListTotCnt(CompanyVO param);
}
