package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MaterialAdjustmentVO;
import org.rnt.com.vo.RtnVO;

public interface MaterialAdjustmentService {
	public RtnVO insert(MaterialAdjustmentVO param);
	public RtnVO select(MaterialAdjustmentVO param);
	public RtnVO update(MaterialAdjustmentVO param);
	public RtnVO delete(MaterialAdjustmentVO param);
	public RtnVO searchList(MaterialAdjustmentVO param);
	public RtnVO searchListTotCnt(MaterialAdjustmentVO param);
	
	public RtnVO updateMaterialIn(MaterialAdjustmentVO param);
	public RtnVO updateMaterialOut(MaterialAdjustmentVO param);
}
