package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.WorkactErrorVO;
import org.rnt.com.vo.RtnVO;

public interface WorkactErrorService {
	public RtnVO insert(WorkactErrorVO param);
	public RtnVO select(WorkactErrorVO param);
	public RtnVO update(WorkactErrorVO param);
	public RtnVO delete(WorkactErrorVO param);
	public RtnVO selectList(WorkactErrorVO param);
}
