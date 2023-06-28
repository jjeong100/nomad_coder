package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.WorkGroupVO;
import org.rnt.com.vo.RtnVO;

public interface WorkGroupService {
	public RtnVO insert(WorkGroupVO param);
	public RtnVO select(WorkGroupVO param);
	public RtnVO update(WorkGroupVO param);
	public RtnVO delete(WorkGroupVO param);
	public RtnVO searchList(WorkGroupVO param);
	public RtnVO searchListTotCnt(WorkGroupVO param);
}
