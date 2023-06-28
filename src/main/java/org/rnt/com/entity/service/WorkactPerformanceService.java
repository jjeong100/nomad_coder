package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.WorkactPerformanceVO;
import org.rnt.com.vo.RtnVO;

public interface WorkactPerformanceService {
	public RtnVO insert(WorkactPerformanceVO param);
	public RtnVO select(WorkactPerformanceVO param);
	public RtnVO update(WorkactPerformanceVO param);
	public RtnVO delete(WorkactPerformanceVO param);
	public RtnVO selectList(WorkactPerformanceVO param);
}
