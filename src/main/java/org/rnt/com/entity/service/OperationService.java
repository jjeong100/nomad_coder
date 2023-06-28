package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.OperationVO;
import org.rnt.com.vo.RtnVO;

public interface OperationService {
	public RtnVO insert(OperationVO param);
	public RtnVO select(OperationVO param);
	public RtnVO update(OperationVO param);
	public RtnVO delete(OperationVO param);
	public RtnVO searchList(OperationVO param);
	public RtnVO searchListTotCnt(OperationVO param);
}
