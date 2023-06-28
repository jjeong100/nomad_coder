package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.OperAuthVO;
import org.rnt.com.vo.RtnVO;

public interface OperAuthService {
	public RtnVO insert(OperAuthVO param);
	public RtnVO select(OperAuthVO param);
	public RtnVO update(OperAuthVO param);
	public RtnVO delete(OperAuthVO param);
	public RtnVO searchList(OperAuthVO param);
	public RtnVO searchListTotCnt(OperAuthVO param);
	public RtnVO selectWorkerCnt(OperAuthVO param);
}
