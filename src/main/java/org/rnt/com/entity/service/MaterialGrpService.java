package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MaterialGrpVO;
import org.rnt.com.vo.RtnVO;

public interface MaterialGrpService {
	public RtnVO insert(MaterialGrpVO param);
	public RtnVO select(MaterialGrpVO param);
	public RtnVO update(MaterialGrpVO param);
	public RtnVO delete(MaterialGrpVO param);
	public RtnVO searchList(MaterialGrpVO param);
	public RtnVO searchListTotCnt(MaterialGrpVO param);
}
