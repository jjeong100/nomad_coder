package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.WorkerVO;
import org.rnt.com.vo.RtnVO;

public interface WorkerService {
	public RtnVO insert(WorkerVO param);
	public RtnVO select(WorkerVO param);
	public RtnVO selectByShortId(WorkerVO param);
	public RtnVO update(WorkerVO param);
	public RtnVO delete(WorkerVO param);
	public RtnVO searchList(WorkerVO param);
	public RtnVO searchListTotCnt(WorkerVO param);
	public RtnVO resetPassWord(WorkerVO param);
}
