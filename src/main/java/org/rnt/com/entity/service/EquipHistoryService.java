package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.EquipVO;
import org.rnt.com.vo.RtnVO;

public interface EquipHistoryService {
	public RtnVO insert(EquipVO param);
	public RtnVO select(EquipVO param);
	public RtnVO update(EquipVO param);
	public RtnVO delete(EquipVO param);
	public RtnVO searchList(EquipVO param);
	public RtnVO searchListTotCnt(EquipVO param);
}
